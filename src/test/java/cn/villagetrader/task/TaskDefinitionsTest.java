package cn.villagetrader.task;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import org.junit.jupiter.api.Test;

final class TaskDefinitionsTest {
  @Test void allTenMainStagesAndGuardianStagesHaveDefinitions() {
    for (int id = 1; id <= 10; id++) {
      assertNotNull(TaskDefinitions.get(TaskDefinitions.Route.MAIN, id));
    }
    for (int id = 1; id <= 6; id++) {
      assertNotNull(TaskDefinitions.get(TaskDefinitions.Route.CHILD, id));
    }
    for (int id = 1; id <= 3; id++) assertNotNull(TaskDefinitions.get(TaskDefinitions.Route.BOSS, id));
    assertEquals(8, TaskDefinitions.get(TaskDefinitions.Route.MAIN, 2).goals().get("diamonds").target());
    assertEquals(4, TaskDefinitions.get(TaskDefinitions.Route.MAIN, 10).goals().get("end_crystals").target());
    assertEquals(16, TaskDefinitions.get(TaskDefinitions.Route.CHILD, 2).goals().get("cobble").target());
  }
}
