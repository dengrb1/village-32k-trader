package cn.villagetrader.achievement;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

final class AchievementDefinitionsTest {
  @Test void catalogueContainsTheFortyDocumentedAchievements() {
    assertEquals(40, AchievementDefinitions.total());
    for (AchievementDefinitions.Category category : AchievementDefinitions.Category.values()) {
      assertEquals(category.target(), AchievementDefinitions.all(category).size());
    }
    assertNotNull(AchievementDefinitions.get("story_10"));
    assertNotNull(AchievementDefinitions.get("guardian_07"));
  }
}
