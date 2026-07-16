package cn.villagetrader.shop;

import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.task.TaskDefinitions;
import java.util.List;

/** Single source of truth for menu visibility and mutation-time progression checks. */
public final class UnlockPolicy {
  private UnlockPolicy() {}

  static boolean good(PlayerProfile profile, int unlockStage) {
    return profile.child.enabled ? profile.child.stage >= unlockStage : profile.main.stage >= unlockStage;
  }

  static boolean auxiliary(PlayerProfile profile, boolean child, int id) {
    if (child != profile.child.enabled) return false;
    if (!child) return id >= 1 && id <= 8 && profile.main.stage >= id;
    if (id >= 1 && id <= 6) return profile.child.stage >= id;
    return profile.child.stage >= 7 && id <= 9 && profile.child.bossStage >= id - 6;
  }

  static boolean task(PlayerProfile profile, TaskDefinitions.Route route, int stage) {
    return switch (route) {
      case MAIN -> !profile.child.enabled && stage == profile.main.stage && stage >= 1 && stage <= 10;
      case CHILD -> profile.child.enabled && profile.child.stage < 7 && stage == profile.child.stage;
      case BOSS -> profile.child.enabled && profile.child.stage >= 7 && stage == profile.child.bossStage && stage >= 1 && stage <= 3;
      case ASCENSION -> ascension(profile);
    };
  }

  static boolean ascension(PlayerProfile profile) {
    return profile.child.enabled && profile.child.stage >= 7 && profile.child.bossStage >= 4
        && profile.child.bossMarks.containsAll(List.of("dragon", "wither", "warden"));
  }

  public static boolean equipment(PlayerProfile profile, int tier) {
    return profile.child.enabled ? childEquipment(profile, tier) : mainEquipment(profile, tier);
  }

  public static boolean mainEquipment(PlayerProfile profile, int tier) {
    if (profile == null) return false;
    if (tier != 5 && tier != 10 && tier != 20 && tier != 32 && tier != 64 && tier != 255) return false;
    if (profile.equipmentTiers != null && profile.equipmentTiers.contains(tier)) return true;
    return switch (tier) {
      case 5 -> profile.main.stage >= 2;
      case 10 -> profile.main.stage >= 3;
      case 20 -> profile.main.stage >= 6;
      case 32 -> profile.main.stage >= 7;
      case 64 -> profile.main.stage >= 9;
      case 255 -> profile.main.stage >= 11;
      default -> false;
    };
  }

  public static boolean childEquipment(PlayerProfile profile, int tier) {
    if (profile == null || !profile.child.enabled) return false;
    return switch (tier) {
      case 1 -> profile.child.stage >= 1;
      case 3 -> profile.child.stage >= 2;
      case 5 -> profile.child.stage >= 3;
      case 10 -> profile.child.stage >= 4;
      case 20 -> profile.child.stage >= 5;
      case 32 -> profile.child.stage >= 6;
      case 128 -> profile.child.ascended;
      default -> false;
    };
  }
}
