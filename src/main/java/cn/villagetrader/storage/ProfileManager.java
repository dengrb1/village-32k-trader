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
import java.util.HashSet;
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
    boolean migrated = false;
    Path file = path(uuid);
    if (Files.exists(file)) {
      try {
        profile = json.read(file, PlayerProfile.class);
        validate(profile, uuid);
        if (profile.schemaVersion < PlayerProfile.CURRENT_SCHEMA) { profile = migrate(profile, file); migrated = true; }
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
    if (migrated) save(profile);
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
      if (version == 1) {
        migrateV1ToV2(profile);
        version = 2;
        continue;
      }
      if (version == 2) {
        migrateV2ToV3(profile);
        version = 3;
        continue;
      }
      throw new IOException("缺少从 schema " + version + " 到新版本的迁移器");
    }
    profile.schemaVersion = version;
    return profile;
  }

  /**
   * The original Paper release used the old six-stage data-pack route.  Keep a
   * player's proven progress, but do not manufacture completion for chapters
   * that were newly inserted in the ten-stage route.
   */
  private void migrateV1ToV2(PlayerProfile p) {
    if (p.freeMainTaskContracts == null) p.freeMainTaskContracts = new HashSet<>();
    if (p.achievements == null) p.achievements = new HashSet<>();
    if (p.achievementBundles == null) p.achievementBundles = new HashSet<>();
    if (p.equipmentTiers == null) p.equipmentTiers = new HashSet<>();

    int oldStage = Math.max(1, p.main.stage);
    int oldActive = p.main.task == null ? 0 : p.main.task.activeId;
    boolean oldHardMode = p.main.hardMode;

    // Active cards become a single free activation for the corresponding new
    // chapter.  Their former partial counters cannot prove the new goals.
    int activeTarget = switch (oldActive) {
      case 1 -> 2;
      case 2 -> 3;
      case 3 -> 5;
      case 4 -> 6;
      case 5 -> 8;
      case 6 -> 9;
      case 7 -> 10;
      default -> 0;
    };
    if (activeTarget > 0) {
      p.main.stage = activeTarget;
      p.freeMainTaskContracts.add(activeTarget);
    } else {
      p.main.stage = switch (oldStage) {
        case 1 -> 1;
        case 2 -> 3;
        case 3 -> 4;
        case 4 -> 6;
        case 5 -> 7;
        case 6 -> 9;
        default -> 10;
      };
    }

    // The old completed route unlocked 64 gear; old hard-mode completion also
    // retains its 255 entitlement while the player works through the new end.
    if (oldStage >= 6) p.equipmentTiers.add(64);
    if (oldStage >= 7 || oldActive == 7 || oldHardMode) p.equipmentTiers.add(255);
    p.main.equipmentTier = 0;
    p.main.task = new PlayerProfile.Task();

    // Only achievements that can be proved by the old route are backfilled.
    if (oldStage >= 2) p.achievements.add("story_02");
    if (oldStage >= 3) p.achievements.add("story_03");
    if (oldStage >= 4) p.achievements.add("story_05");
    if (oldStage >= 5) p.achievements.add("story_06");
    if (oldStage >= 6) p.achievements.add("story_08");
    if (oldActive == 7) p.achievements.add("story_09");
    if (p.child != null) {
      if (p.child.stage >= 2) p.achievements.add("guardian_01");
      if (p.child.stage >= 4) p.achievements.add("guardian_02");
      if (p.child.stage >= 7) p.achievements.add("guardian_03");
      if (p.child.bossMarks != null) {
        if (p.child.bossMarks.contains("dragon")) p.achievements.add("guardian_04");
        if (p.child.bossMarks.contains("wither")) p.achievements.add("guardian_05");
        if (p.child.bossMarks.contains("warden")) p.achievements.add("guardian_06");
      }
      if (p.child.ascended) p.achievements.add("guardian_07");
    }
  }

  /**
   * v3 replaces repeatable full equipment bundles with permanent passes.  A
   * v2 player keeps the highest level they could already use on each route;
   * no inventory item is edited or removed.
   */
  private void migrateV2ToV3(PlayerProfile p) {
    if (p.mainEquipmentPasses == null) p.mainEquipmentPasses = new HashSet<>();
    if (p.childEquipmentPasses == null) p.childEquipmentPasses = new HashSet<>();
    if (p.auxiliaryStates == null) p.auxiliaryStates = new java.util.HashMap<>();
    int main = highestMainTier(p);
    int child = highestChildTier(p);
    if (main > 0) p.mainEquipmentPasses.add(main);
    if (child > 0) p.childEquipmentPasses.add(child);
  }

  private int highestMainTier(PlayerProfile p) {
    if (p.equipmentTiers != null) {
      for (int tier : new int[] {255, 64, 32, 20, 10, 5}) if (p.equipmentTiers.contains(tier)) return tier;
    }
    if (p.main.stage >= 11) return 255;
    if (p.main.stage >= 9) return 64;
    if (p.main.stage >= 7) return 32;
    if (p.main.stage >= 6) return 20;
    if (p.main.stage >= 3) return 10;
    return p.main.stage >= 2 ? 5 : 0;
  }

  private int highestChildTier(PlayerProfile p) {
    if (p.child.ascended) return 128;
    if (p.child.stage >= 6) return 32;
    if (p.child.stage >= 5) return 20;
    if (p.child.stage >= 4) return 10;
    if (p.child.stage >= 3) return 5;
    if (p.child.stage >= 2) return 3;
    return p.child.stage >= 1 ? 1 : 0;
  }

  private void normalize(PlayerProfile p) {
    if (p.main == null) p.main = new PlayerProfile.Route(1);
    if (p.child == null) p.child = new PlayerProfile.ChildRoute();
    if (p.main.task == null) p.main.task = new PlayerProfile.Task();
    if (p.child.task == null) p.child.task = new PlayerProfile.Task();
    if (p.child.bossTask == null) p.child.bossTask = new PlayerProfile.Task();
    if (p.mainAuxiliaries == null) p.mainAuxiliaries = ConcurrentHashMap.newKeySet();
    if (p.childAuxiliaries == null) p.childAuxiliaries = ConcurrentHashMap.newKeySet();
    if (p.mainEquipmentPasses == null) p.mainEquipmentPasses = ConcurrentHashMap.newKeySet();
    if (p.childEquipmentPasses == null) p.childEquipmentPasses = ConcurrentHashMap.newKeySet();
    if (p.auxiliaryStates == null) p.auxiliaryStates = new ConcurrentHashMap<>();
    if (p.equipmentTiers == null) p.equipmentTiers = ConcurrentHashMap.newKeySet();
    if (p.freeMainTaskContracts == null) p.freeMainTaskContracts = ConcurrentHashMap.newKeySet();
    if (p.achievements == null) p.achievements = ConcurrentHashMap.newKeySet();
    if (p.achievementBundles == null) p.achievementBundles = ConcurrentHashMap.newKeySet();
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
