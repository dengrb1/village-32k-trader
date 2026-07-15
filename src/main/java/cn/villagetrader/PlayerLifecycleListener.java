package cn.villagetrader;

import cn.villagetrader.model.PlayerProfile;
import java.io.IOException;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.player.PlayerJoinEvent;
import org.bukkit.event.player.PlayerQuitEvent;

public final class PlayerLifecycleListener implements Listener {
  private final VillageTraderPlugin plugin;
  public PlayerLifecycleListener(VillageTraderPlugin plugin){this.plugin=plugin;}
  @EventHandler public void join(PlayerJoinEvent event){ load(event.getPlayer()); }
  public void load(org.bukkit.entity.Player player){
    try{
      boolean exists=plugin.profiles().exists(player.getUniqueId());PlayerProfile p;
      if(!exists&&plugin.getConfig().getBoolean("legacy-migration.enabled",true)){p=plugin.legacy().migrate(player);plugin.profiles().adopt(p);plugin.profiles().save(p);player.sendMessage(Component.text("已从旧数据包状态生成一次性 JSON 档案。",NamedTextColor.GREEN));}
      else p=plugin.profiles().load(player.getUniqueId(),player.getName());
      if(plugin.getConfig().getBoolean("legacy-migration.convert-items-on-join",true)){int converted=plugin.items().convertLegacyItems(player);if(converted>0){plugin.profiles().save(p);player.sendMessage(Component.text("已转换 "+converted+" 个旧 custom_data 物品。",NamedTextColor.AQUA));}}
      plugin.bossBars().update(player);
    }catch(IOException ex){plugin.getLogger().severe("玩家档案加载失败: "+ex.getMessage());player.kick(Component.text("VillageTrader 档案加载失败；为保护进度已拒绝进入。",NamedTextColor.RED));}
  }
  @EventHandler public void quit(PlayerQuitEvent event){PlayerProfile p=plugin.profiles().get(event.getPlayer().getUniqueId());plugin.bossBars().hide(event.getPlayer());if(p!=null)plugin.profiles().save(p).whenComplete((ok,error)->plugin.profiles().unload(event.getPlayer().getUniqueId()));}
}
