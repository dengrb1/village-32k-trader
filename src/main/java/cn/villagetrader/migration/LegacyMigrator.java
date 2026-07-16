package cn.villagetrader.migration;

import cn.villagetrader.achievement.AchievementDefinitions;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.storage.ServerStateManager;
import java.io.IOException;
import java.util.Set;
import org.bukkit.Bukkit;
import org.bukkit.entity.Player;
import org.bukkit.entity.Villager;
import org.bukkit.scoreboard.Objective;
import org.bukkit.scoreboard.Scoreboard;

public final class LegacyMigrator {
  private final ItemService items;
  private final ServerStateManager serverState;

  public LegacyMigrator(ItemService items, ServerStateManager serverState) { this.items=items;this.serverState=serverState; }

  public PlayerProfile migrate(Player player) {
    PlayerProfile p=new PlayerProfile(player.getUniqueId(),player.getName());
    int sourceVersion=score(player,"vt_version",1);int sourceStage=Math.max(1,score(player,"vt_stage",1));int sourceActive=score(player,"vt_qactive",0);
    p.main.stage=sourceStage;p.main.hardMode=score(player,"vt_diff",0)==1;p.main.equipmentTier=equipmentTier(score(player,"vt_gear",0));
    p.main.task.activeId=sourceActive;p.main.task.ownedCardId=score(player,"vt_qown",0);p.main.task.replacementClaimed=score(player,"vt_qrep",0)==1;
    if(sourceVersion>=2){copyCurrentMainProgress(p.main.task,player);if(p.main.stage>=11||p.main.task.activeId>10)p.main.task.clear();}
    else migrateV1Main(p,sourceStage,sourceActive);
    p.child.enabled=score(player,"vt_child",0)==1;p.child.stage=score(player,"vt_cstage",1);p.child.task.activeId=score(player,"vt_cactive",0);p.child.task.ownedCardId=score(player,"vt_cqown",0);p.child.task.replacementClaimed=score(player,"vt_cqrep",0)==1;
    copyChildProgress(p.child.task,player);p.child.bossStage=score(player,"vt_bstage",1);p.child.bossTask.activeId=score(player,"vt_bactive",0)==1?p.child.bossStage:0;p.child.bossTask.ownedCardId=score(player,"vt_bqown",0)==1?p.child.bossStage:0;
    p.child.ascended=score(player,"vt_asc",0)==1;p.child.ascensionKeyOwned=score(player,"vt_asckey",0)==1;p.selectedMainAuxiliary=score(player,"vt_aux",0);p.selectedChildAuxiliary=score(player,"vt_caux",0);p.portableKeyAuthorized=score(player,"vt_portable",0)==1;
    Set<String> tags=player.getScoreboardTags();for(int i=1;i<=6;i++)if(tags.contains("village_trader.main_aux_"+i))p.mainAuxiliaries.add(i);for(int i=1;i<=9;i++)if(tags.contains("village_trader.child_aux_"+i))p.childAuxiliaries.add(i);
    if(tags.contains("village_trader.mark_dragon"))p.child.bossMarks.add("dragon");if(tags.contains("village_trader.mark_wither"))p.child.bossMarks.add("wither");if(tags.contains("village_trader.mark_warden"))p.child.bossMarks.add("warden");
    if(p.main.equipmentTier>0)p.equipmentTiers.add(p.main.equipmentTier);if(tags.contains("village_trader.legacy_64"))p.equipmentTiers.add(64);if(tags.contains("village_trader.legacy_255"))p.equipmentTiers.add(255);if(p.child.ascended)p.equipmentTiers.add(128);
    if(sourceVersion>=2){importAchievementTags(p,tags);backfillV2Achievements(p);}else backfillV1Achievements(p,sourceStage,sourceActive);
    items.convertLegacyItems(player);p.legacyMigrated=true;p.touch(player.getName());return p;
  }

  public void migrateServerState() {
    Scoreboard board=Bukkit.getScoreboardManager().getMainScoreboard();Objective objective=board.getObjective("vt_penalty");
    if(objective!=null){var score=objective.getScore("$level");if(score.isScoreSet())try{serverState.setPenalty(score.getScore());}catch(IOException ignored){}}
    for (Villager villager : Bukkit.getWorlds().stream().flatMap(world -> world.getEntitiesByClass(Villager.class).stream()).toList()) {
      if (!villager.getScoreboardTags().contains("village_trader.merchant")) continue;
      boolean known = serverState.state().shops.stream().anyMatch(record -> villager.getUniqueId().equals(record.merchantUuid));
      if (known) continue;
      cn.villagetrader.model.ServerState.ShopRecord record = new cn.villagetrader.model.ServerState.ShopRecord();
      record.world = villager.getWorld().getName(); record.x = villager.getX(); record.y = villager.getY(); record.z = villager.getZ(); record.merchantUuid = villager.getUniqueId(); record.houseBuilt = true;
      serverState.state().shops.add(record);
    }
    try { serverState.save(); } catch (IOException ignored) {}
  }

  private int score(Player player,String objectiveName,int fallback){Objective objective=Bukkit.getScoreboardManager().getMainScoreboard().getObjective(objectiveName);if(objective==null)return fallback;var value=objective.getScore(player.getName());return value.isScoreSet()?value.getScore():fallback;}
  private void copyCurrentMainProgress(PlayerProfile.Task t,Player p){map(t,new int[]{score(p,"vt_a",0),score(p,"vt_b",0),score(p,"vt_c",0)},new String[][]{{},{"crafting_table","sleep"},{"diamonds","hostiles"},{"nether","blazes","debris"},{"elder_guardian","conduit"},{"end","dragon"},{"raid","totem"},{"breezes","trial_key"},{"wither","beacon"},{"warden","echo_shards"},{"end_crystals","dragon"}});}
  private void copyChildProgress(PlayerProfile.Task t,Player p){map(t,new int[]{score(p,"vt_ca",0),score(p,"vt_cb",0),score(p,"vt_cc",0)},new String[][]{{},{"logs","table"},{"cobble","iron"},{"torches","eat","sleep"},{"shield","training_kills"},{"purchase","diamond","emeralds"},{"merchant"}});}
  private void map(PlayerProfile.Task t,int[] values,String[][] keys){int id=t.activeId;if(id>=1&&id<keys.length)for(int i=0;i<keys[id].length;i++)t.progress.put(keys[id][i],values[i]);}

  private void migrateV1Main(PlayerProfile p,int oldStage,int oldActive){
    int activeTarget=switch(oldActive){case 1->2;case 2->3;case 3->5;case 4->6;case 5->8;case 6->9;case 7->10;default->0;};
    if(activeTarget>0){p.main.stage=activeTarget;p.freeMainTaskContracts.add(activeTarget);}else p.main.stage=switch(oldStage){case 1->1;case 2->3;case 3->4;case 4->6;case 5->7;case 6->9;default->10;};
    if(oldStage>=6)p.equipmentTiers.add(64);if(oldStage>=7||oldActive==7||p.main.hardMode)p.equipmentTiers.add(255);
    p.main.equipmentTier=0;p.main.task.clear();
  }

  private int equipmentTier(int legacyGear){return switch(legacyGear){case 1->5;case 2->10;case 3->20;case 4->32;case 5->64;case 6,7,255->255;case 10,20,32,64,128->legacyGear;default->0;};}

  private void importAchievementTags(PlayerProfile p,Set<String> tags){
    for(AchievementDefinitions.Definition definition:AchievementDefinitions.all())if(tags.contains("village_trader.ach."+definition.id()))p.achievements.add(definition.id());
    for(AchievementDefinitions.Category category:AchievementDefinitions.Category.values())if(tags.contains("village_trader.achievement_bundle_"+category.key()))p.achievementBundles.add("category_"+category.key());
    if(tags.contains("village_trader.achievement_all_claimed"))p.achievementBundles.add("all_40");
  }

  private void backfillV1Achievements(PlayerProfile p,int oldStage,int oldActive){
    if(oldStage>=2)p.achievements.add("story_02");if(oldStage>=3)p.achievements.add("story_03");if(oldStage>=4)p.achievements.add("story_05");if(oldStage>=5)p.achievements.add("story_06");if(oldStage>=6)p.achievements.add("story_08");if(oldActive==7)p.achievements.add("story_09");backfillGuardianAchievements(p);
  }

  private void backfillV2Achievements(PlayerProfile p){
    for(int chapter=1;chapter<Math.min(11,p.main.stage);chapter++)addMainCompletionAchievements(p,chapter);
    if(p.main.stage>=2)p.achievements.add("trade_01");
    backfillGuardianAchievements(p);
  }

  private void addMainCompletionAchievements(PlayerProfile p,int chapter){
    p.achievements.add("story_"+String.format("%02d",chapter));
    switch(chapter){case 2->{p.achievements.add("explore_01");p.achievements.add("combat_01");}case 3->{p.achievements.add("explore_02");p.achievements.add("combat_02");}case 4->{p.achievements.add("explore_03");p.achievements.add("combat_03");}case 5->{p.achievements.add("explore_04");p.achievements.add("combat_04");}case 6->p.achievements.add("combat_05");case 7->{p.achievements.add("explore_05");p.achievements.add("combat_06");}case 8->{p.achievements.add("explore_06");p.achievements.add("combat_07");}case 9->{p.achievements.add("explore_07");p.achievements.add("combat_08");}case 10->p.achievements.add("explore_08");default->{}}
  }

  private void backfillGuardianAchievements(PlayerProfile p){
    if(p.child.stage>=2)p.achievements.add("guardian_01");if(p.child.stage>=4)p.achievements.add("guardian_02");if(p.child.stage>=7)p.achievements.add("guardian_03");if(p.child.bossMarks.contains("dragon"))p.achievements.add("guardian_04");if(p.child.bossMarks.contains("wither"))p.achievements.add("guardian_05");if(p.child.bossMarks.contains("warden"))p.achievements.add("guardian_06");if(p.child.ascended)p.achievements.add("guardian_07");
  }
}
