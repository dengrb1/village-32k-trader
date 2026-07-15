package cn.villagetrader.storage;

import cn.villagetrader.model.PlayerProfile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Instant;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;

public final class ProfileManager implements AutoCloseable {
  private final JsonStore json;
  private final Path profilesDir;
  private final Path backupsDir;
  private final Path exportsDir;
  private final Logger logger;
  private final ExecutorService writer = Executors.newSingleThreadExecutor(r -> {
    Thread t = new Thread(r, "VillageTrader-ProfileWriter");
    t.setDaemon(true);
    return t;
  });
  private final Map<UUID, PlayerProfile> loaded = new ConcurrentHashMap<>();
  private final Map<UUID, CompletableFuture<Void>> pendingWrites = new ConcurrentHashMap<>();

  public ProfileManager(Path dataDir, JsonStore json, Logger logger) throws IOException {
    this.json = json;
    this.logger = logger;
    profilesDir = dataDir.resolve("profiles");
    backupsDir = dataDir.resolve("backups");
    exportsDir = dataDir.resolve("exports");
    Files.createDirectories(profilesDir);
    Files.createDirectories(backupsDir);
    Files.createDirectories(exportsDir);
  }

  public boolean exists(UUID uuid) { return Files.exists(path(uuid)); }
  public PlayerProfile get(UUID uuid) { return loaded.get(uuid); }
  public void adopt(PlayerProfile profile) { normalize(profile); loaded.put(profile.uuid, profile); }
  public Collection<PlayerProfile> loadedProfiles() { return new ArrayList<>(loaded.values()); }

  public PlayerProfile load(UUID uuid, String name) throws IOException {
    PlayerProfile profile;
    Path file = path(uuid);
    if (Files.exists(file)) {
      try {
        profile = json.read(file, PlayerProfile.class);
        validate(profile, uuid);
        if (profile.schemaVersion < PlayerProfile.CURRENT_SCHEMA) profile = migrate(profile, file);
      } catch (IOException ex) {
        logger.log(Level.SEVERE, "档案加载失败，已锁定且不会覆盖: " + file, ex);
        profile = new PlayerProfile(uuid, name);
        profile.writeBlocked = true;
      }
    } else {
      profile = new PlayerProfile(uuid, name);
    }
    normalize(profile);
    profile.touch(name);
    loaded.put(uuid, profile);
    return profile;
  }

  public CompletableFuture<Void> save(PlayerProfile profile) {
    if (profile == null || profile.writeBlocked) return CompletableFuture.completedFuture(null);
    PlayerProfile snapshot = json.gson().fromJson(json.gson().toJson(profile), PlayerProfile.class);
    snapshot.updatedAt = Instant.now();
    CompletableFuture<Void> previous = pendingWrites.getOrDefault(profile.uuid, CompletableFuture.completedFuture(null));
    CompletableFuture<Void> next = previous.handle((ok, error) -> null).thenRunAsync(() -> {
      try { json.writeAtomic(path(snapshot.uuid), snapshot); }
      catch (IOException ex) { throw new RuntimeException(ex); }
    }, writer).whenComplete((ok, error) -> {
      if (error != null) logger.log(Level.SEVERE, "异步保存档案失败: " + snapshot.uuid, error);
    });
    pendingWrites.put(profile.uuid, next);
    return next;
  }

  public Path exportProfile(PlayerProfile profile) throws IOException {
    String stamp = DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss").withZone(ZoneOffset.UTC).format(Instant.now());
    Path target = exportsDir.resolve(profile.uuid + "-" + stamp + ".json");
    json.writeAtomic(target, profile);
    return target;
  }

  public PlayerProfile importProfile(UUID expected, String fileName) throws IOException {
    Path requested = exportsDir.resolve(fileName).normalize();
    if (!requested.startsWith(exportsDir) || !Files.isRegularFile(requested)) throw new IOException("只允许导入 exports/ 内的现有文件");
    PlayerProfile incoming = json.read(requested, PlayerProfile.class);
    validate(incoming, expected);
    if (incoming.schemaVersion > PlayerProfile.CURRENT_SCHEMA) throw new IOException("档案版本高于本插件支持版本");
    if (incoming.schemaVersion < PlayerProfile.CURRENT_SCHEMA) incoming = migrate(incoming, requested);
    Path current = path(expected);
    json.backup(current, backupsDir, "pre-import");
    normalize(incoming);
    incoming.writeBlocked = false;
    incoming.updatedAt = Instant.now();
    json.writeAtomic(current, incoming);
    loaded.put(expected, incoming);
    return incoming;
  }

  public void unload(UUID uuid) { loaded.remove(uuid); }
  public Path profilesDirectory() { return profilesDir; }
  public Path exportsDirectory() { return exportsDir; }

  private Path path(UUID uuid) { return profilesDir.resolve(uuid + ".json"); }

  private void validate(PlayerProfile profile, UUID expected) throws IOException {
    if (profile.uuid == null || !profile.uuid.equals(expected)) throw new IOException("档案 UUID 与目标玩家不一致");
    if (profile.schemaVersion < 1) throw new IOException("无效 schemaVersion");
  }

  private PlayerProfile migrate(PlayerProfile profile, Path source) throws IOException {
    json.backup(source, backupsDir, "pre-migration-v" + profile.schemaVersion);
    int version = profile.schemaVersion;
    while (version < PlayerProfile.CURRENT_SCHEMA) {
      // 后续 schema 在这里按 vN -> vN+1 顺序迁移，禁止跳版本。
      throw new IOException("缺少从 schema " + version + " 到新版本的迁移器");
    }
    profile.schemaVersion = version;
    return profile;
  }

  private void normalize(PlayerProfile p) {
    if (p.main == null) p.main = new PlayerProfile.Route(1);
    if (p.child == null) p.child = new PlayerProfile.ChildRoute();
    if (p.main.task == null) p.main.task = new PlayerProfile.Task();
    if (p.child.task == null) p.child.task = new PlayerProfile.Task();
    if (p.child.bossTask == null) p.child.bossTask = new PlayerProfile.Task();
    if (p.mainAuxiliaries == null) p.mainAuxiliaries = ConcurrentHashMap.newKeySet();
    if (p.childAuxiliaries == null) p.childAuxiliaries = ConcurrentHashMap.newKeySet();
    if (p.equipmentTiers == null) p.equipmentTiers = ConcurrentHashMap.newKeySet();
    if (p.statisticBaselines == null) p.statisticBaselines = new ConcurrentHashMap<>();
    if (p.cooldowns == null) p.cooldowns = new ConcurrentHashMap<>();
    if (p.settings == null) p.settings = new ConcurrentHashMap<>();
    if (p.child.bossMarks == null) p.child.bossMarks = ConcurrentHashMap.newKeySet();
  }

  @Override public void close() {
    CompletableFuture.allOf(pendingWrites.values().toArray(CompletableFuture[]::new)).join();
    writer.shutdown();
  }
}
