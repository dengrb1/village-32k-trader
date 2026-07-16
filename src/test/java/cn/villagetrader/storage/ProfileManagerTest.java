package cn.villagetrader.storage;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import cn.villagetrader.model.PlayerProfile;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.UUID;
import java.util.logging.Logger;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

final class ProfileManagerTest {
  @TempDir Path temp;

  @Test void corruptedProfileIsWriteBlockedAndNeverOverwritten() throws Exception {
    UUID uuid = UUID.randomUUID();
    Path file = temp.resolve("profiles").resolve(uuid + ".json");
    Files.createDirectories(file.getParent());
    Files.writeString(file, "{broken", StandardCharsets.UTF_8);
    try (ProfileManager manager = new ProfileManager(temp, new JsonStore(), Logger.getAnonymousLogger())) {
      PlayerProfile loaded = manager.load(uuid, "Tester");
      assertTrue(loaded.writeBlocked);
      manager.save(loaded).join();
      assertEquals("{broken", Files.readString(file, StandardCharsets.UTF_8));
    }
  }

  @Test void importRejectsDifferentUuidWithoutReplacingCurrentProfile() throws Exception {
    UUID target = UUID.randomUUID();
    UUID other = UUID.randomUUID();
    JsonStore json = new JsonStore();
    try (ProfileManager manager = new ProfileManager(temp, json, Logger.getAnonymousLogger())) {
      PlayerProfile current = new PlayerProfile(target, "Target");
      manager.adopt(current); manager.save(current).join();
      PlayerProfile foreign = new PlayerProfile(other, "Other");
      Path export = manager.exportsDirectory().resolve("foreign.json");
      json.writeAtomic(export, foreign);
      assertThrows(java.io.IOException.class, () -> manager.importProfile(target, "foreign.json"));
      assertEquals(target, json.read(manager.profilesDirectory().resolve(target + ".json"), PlayerProfile.class).uuid);
    }
  }

  @Test void v1ProfileMigratesToTenChapterRouteWithoutLosingEntitlements() throws Exception {
    UUID uuid = UUID.randomUUID();
    JsonStore json = new JsonStore();
    PlayerProfile legacy = new PlayerProfile(uuid, "Tester");
    legacy.schemaVersion = 1;
    legacy.main.stage = 6;
    legacy.main.task.activate(6);
    legacy.freeMainTaskContracts = null;
    legacy.achievements = null;
    legacy.achievementBundles = null;
    Path file = temp.resolve("profiles").resolve(uuid + ".json");
    Files.createDirectories(file.getParent());
    json.writeAtomic(file, legacy);

    try (ProfileManager manager = new ProfileManager(temp, json, Logger.getAnonymousLogger())) {
      PlayerProfile migrated = manager.load(uuid, "Tester");
      assertEquals(PlayerProfile.CURRENT_SCHEMA, migrated.schemaVersion);
      assertEquals(9, migrated.main.stage);
      assertTrue(migrated.freeMainTaskContracts.contains(9));
      assertEquals(0, migrated.main.task.activeId);
      assertTrue(migrated.equipmentTiers.contains(64));
      assertTrue(migrated.achievements.contains("story_08"));
    }
  }
}
