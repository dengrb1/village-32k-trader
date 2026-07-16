package cn.villagetrader.model;

import java.time.Instant;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

public final class PlayerProfile {
  public static final int CURRENT_SCHEMA = 2;

  public int schemaVersion = CURRENT_SCHEMA;
  public UUID uuid;
  public String lastName = "";
  public Instant updatedAt = Instant.now();
  public boolean legacyMigrated;
  public boolean writeBlocked;
  public Route main = new Route(1);
  public ChildRoute child = new ChildRoute();
  public Set<Integer> mainAuxiliaries = new HashSet<>();
  public Set<Integer> childAuxiliaries = new HashSet<>();
  public int selectedMainAuxiliary;
  public int selectedChildAuxiliary;
  public boolean portableKeyAuthorized;
  public Set<Integer> equipmentTiers = new HashSet<>();
  /** One-time no-cost task activations issued while migrating the former six-stage main route. */
  public Set<Integer> freeMainTaskContracts = new HashSet<>();
  /** Stable achievement identifiers, for example {@code story_01}. */
  public Set<String> achievements = new HashSet<>();
  /** One-time category and 40/40 reward identifiers already claimed. */
  public Set<String> achievementBundles = new HashSet<>();
  public Map<String, Long> statisticBaselines = new HashMap<>();
  public Map<String, Long> cooldowns = new HashMap<>();
  public Map<String, Boolean> settings = new HashMap<>();

  public PlayerProfile() {}

  public PlayerProfile(UUID uuid, String name) {
    this.uuid = uuid;
    this.lastName = name;
    this.main.stage = 1;
    this.main.equipmentTier = 1;
    this.child.stage = 1;
    this.child.bossStage = 1;
  }

  public void touch(String name) {
    lastName = name;
    updatedAt = Instant.now();
  }

  public static class Route {
    public int stage;
    public boolean hardMode;
    public int equipmentTier;
    public Task task = new Task();

    public Route() {}
    public Route(int stage) { this.stage = stage; }
  }

  public static final class ChildRoute extends Route {
    public boolean enabled;
    public int bossStage = 1;
    public Task bossTask = new Task();
    public boolean ascended;
    public boolean ascensionKeyOwned;
    public Set<String> bossMarks = new HashSet<>();
  }

  public static final class Task {
    public int activeId;
    public int ownedCardId;
    public boolean replacementClaimed;
    public Map<String, Integer> progress = new HashMap<>();

    public void activate(int id) {
      activeId = id;
      ownedCardId = id;
      replacementClaimed = false;
      progress.clear();
    }

    public void clear() {
      activeId = 0;
      ownedCardId = 0;
      replacementClaimed = false;
      progress.clear();
    }
  }
}
