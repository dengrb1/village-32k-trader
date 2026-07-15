package cn.villagetrader.migration;

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
    p.main.stage=score(player,"vt_stage",1);p.main.hardMode=score(player,"vt_diff",0)==1;p.main.equipmentTier=score(player,"vt_gear",1);
    p.main.task.activeId=score(player,"vt_qactive",0);p.main.task.ownedCardId=score(player,"vt_qown",0);p.main.task.replacementClaimed=score(player,"vt_qrep",0)==1;
    copyMainProgress(p.main.task,player);
    p.child.enabled=score(player,"vt_child",0)==1;p.child.stage=score(player,"vt_cstage",1);p.child.task.activeId=score(player,"vt_cactive",0);p.child.task.ownedCardId=score(player,"vt_cqown",0);p.child.task.replacementClaimed=score(player,"vt_cqrep",0)==1;
    copyChildProgress(p.child.task,player);p.child.bossStage=score(player,"vt_bstage",1);p.child.bossTask.activeId=score(player,"vt_bactive",0)==1?p.child.bossStage:0;p.child.bossTask.ownedCardId=score(player,"vt_bqown",0)==1?p.child.bossStage:0;
    p.child.ascended=score(player,"vt_asc",0)==1;p.child.ascensionKeyOwned=score(player,"vt_asckey",0)==1;p.selectedMainAuxiliary=score(player,"vt_aux",0);p.selectedChildAuxiliary=score(player,"vt_caux",0);p.portableKeyAuthorized=score(player,"vt_portable",0)==1;
    Set<String> tags=player.getScoreboardTags();for(int i=1;i<=6;i++)if(tags.contains("village_trader.main_aux_"+i))p.mainAuxiliaries.add(i);for(int i=1;i<=9;i++)if(tags.contains("village_trader.child_aux_"+i))p.childAuxiliaries.add(i);
    if(tags.contains("village_trader.mark_dragon"))p.child.bossMarks.add("dragon");if(tags.contains("village_trader.mark_wither"))p.child.bossMarks.add("wither");if(tags.contains("village_trader.mark_warden"))p.child.bossMarks.add("warden");
    if(p.main.equipmentTier>0)p.equipmentTiers.add(p.main.equipmentTier);if(p.child.ascended)p.equipmentTiers.add(128);
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
  private void copyMainProgress(PlayerProfile.Task t,Player p){map(t,new int[]{score(p,"vt_a",0),score(p,"vt_b",0),score(p,"vt_c",0)},new String[][]{{},{"diamonds","hostiles"},{"nether","blazes","debris"},{"end","dragon"},{"raid","totem"},{"wither","beacon"},{"warden"}});}
  private void copyChildProgress(PlayerProfile.Task t,Player p){map(t,new int[]{score(p,"vt_ca",0),score(p,"vt_cb",0),score(p,"vt_cc",0)},new String[][]{{},{"logs","table"},{"cobble","iron"},{"torches","eat","sleep"},{"shield","training_kills"},{"purchase","diamond","emeralds"},{"merchant"}});}
  private void map(PlayerProfile.Task t,int[] values,String[][] keys){int id=t.activeId;if(id>=1&&id<keys.length)for(int i=0;i<keys[id].length;i++)t.progress.put(keys[id][i],values[i]);}
}
