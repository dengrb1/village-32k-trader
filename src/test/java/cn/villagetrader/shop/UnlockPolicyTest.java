package cn.villagetrader.shop;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.task.TaskDefinitions;
import java.util.UUID;
import org.junit.jupiter.api.Test;

final class UnlockPolicyTest {
  @Test void mainStagesGateGoodsAuxiliariesTasksAndEquipment() {
    PlayerProfile profile = profile();
    for (int stage = 1; stage <= 10; stage++) {
      profile.main.stage = stage;
      assertTrue(UnlockPolicy.good(profile, stage));
      assertTrue(UnlockPolicy.task(profile, TaskDefinitions.Route.MAIN, stage));
      if (stage <= 6) assertTrue(UnlockPolicy.auxiliary(profile, false, stage));
      assertFalse(UnlockPolicy.auxiliary(profile, false, 7));
      if (stage < 10) assertFalse(UnlockPolicy.task(profile, TaskDefinitions.Route.MAIN, stage + 1));
    }
    profile.main.stage = 2;
    assertTrue(UnlockPolicy.equipment(profile, 5));
    assertFalse(UnlockPolicy.equipment(profile, 10));
    profile.main.stage = 3;
    assertTrue(UnlockPolicy.equipment(profile, 10));
    profile.main.stage = 6;
    assertTrue(UnlockPolicy.equipment(profile, 20));
    profile.main.stage = 7;
    assertTrue(UnlockPolicy.equipment(profile, 32));
    profile.main.stage = 9;
    assertTrue(UnlockPolicy.equipment(profile, 64));
    assertFalse(UnlockPolicy.equipment(profile, 255));
    profile.main.stage = 11;
    assertTrue(UnlockPolicy.equipment(profile, 255));
  }

  @Test void childChaptersAndBossStagesOnlyExposeTheirOwnEntries() {
    PlayerProfile profile = profile();
    profile.child.enabled = true;
    for (int stage = 1; stage <= 6; stage++) {
      profile.child.stage = stage;
      assertTrue(UnlockPolicy.good(profile, stage));
      assertTrue(UnlockPolicy.auxiliary(profile, true, stage));
      assertTrue(UnlockPolicy.task(profile, TaskDefinitions.Route.CHILD, stage));
      assertFalse(UnlockPolicy.auxiliary(profile, true, 7));
    }
    profile.child.stage = 7;
    for (int bossStage = 1; bossStage <= 3; bossStage++) {
      profile.child.bossStage = bossStage;
      assertTrue(UnlockPolicy.task(profile, TaskDefinitions.Route.BOSS, bossStage));
      assertTrue(UnlockPolicy.auxiliary(profile, true, bossStage + 6));
      if (bossStage < 3) assertFalse(UnlockPolicy.auxiliary(profile, true, bossStage + 7));
    }
  }

  @Test void ascensionAndGuardianEquipmentRequireAllMarksAndCompletion() {
    PlayerProfile profile = profile();
    profile.child.enabled = true;
    profile.child.stage = 7;
    profile.child.bossStage = 4;
    assertFalse(UnlockPolicy.ascension(profile));
    profile.child.bossMarks.addAll(java.util.List.of("dragon", "wither", "warden"));
    assertTrue(UnlockPolicy.ascension(profile));
    assertFalse(UnlockPolicy.equipment(profile, 128));
    profile.child.ascended = true;
    assertTrue(UnlockPolicy.equipment(profile, 128));
  }

  private PlayerProfile profile() {
    return new PlayerProfile(UUID.randomUUID(), "Tester");
  }
}
