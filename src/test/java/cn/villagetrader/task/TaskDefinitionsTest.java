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
    for (int id = 1; id <= 10; id++) {
      int goals = TaskDefinitions.get(TaskDefinitions.Route.MAIN, id).goals().size();
      assertEquals(true, goals >= 3 && goals <= 4);
    }
    assertEquals(4, TaskDefinitions.get(TaskDefinitions.Route.MAIN, 1).goals().get("smelt_iron").target());
    assertEquals(3, TaskDefinitions.get(TaskDefinitions.Route.MAIN, 8).goals().get("wither_skulls").target());
  }
}
