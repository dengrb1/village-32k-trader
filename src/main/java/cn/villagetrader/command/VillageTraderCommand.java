package cn.villagetrader.command;

import cn.villagetrader.VillageTraderPlugin;
import cn.villagetrader.model.PlayerProfile;
import java.io.IOException;
import java.nio.file.Path;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Bukkit;
import org.bukkit.OfflinePlayer;
import org.bukkit.command.Command;
import org.bukkit.command.CommandExecutor;
import org.bukkit.command.CommandSender;
import org.bukkit.command.TabCompleter;
import org.bukkit.entity.Player;

public final class VillageTraderCommand implements CommandExecutor, TabCompleter {
  private final VillageTraderPlugin plugin;
  public VillageTraderCommand(VillageTraderPlugin plugin){this.plugin=plugin;}

  @Override public boolean onCommand(CommandSender sender,Command command,String label,String[] args){
    if(args.length==0||args[0].equalsIgnoreCase("help")){help(sender);return true;}
    if(args[0].equalsIgnoreCase("open")&&sender instanceof Player player){plugin.shop().open(player);return true;}
    if(!sender.hasPermission("villagetrader.admin")){sender.sendMessage(Component.text("没有管理权限。",NamedTextColor.RED));return true;}
    try{
      switch(args[0].toLowerCase()){
        case "profile"->profile(sender,args);
        case "key"->key(sender,args);
        case "child"->child(sender,args);
        case "penalty"->penalty(sender,args);
        case "shop"->shop(sender,args);
        case "nightvision"->nightVision(sender,args);
        default->help(sender);
      }
    }catch(Exception ex){sender.sendMessage(Component.text("命令失败："+ex.getMessage(),NamedTextColor.RED));plugin.getLogger().warning("命令失败: "+ex);}
    return true;
  }

  private void profile(CommandSender sender,String[] a)throws IOException{
    if(a.length<3){sender.sendMessage("/vt profile <export|import|status> <player> [file]");return;}Player target=requirePlayer(a[2]);PlayerProfile p=plugin.profiles().get(target.getUniqueId());if(p==null)p=plugin.profiles().load(target.getUniqueId(),target.getName());
    switch(a[1].toLowerCase()){
      case "export"->{Path file=plugin.profiles().exportProfile(p);sender.sendMessage(Component.text("已导出："+file.getFileName(),NamedTextColor.GREEN));}
      case "import"->{if(a.length<4)throw new IllegalArgumentException("缺少 exports/ 内文件名");p=plugin.profiles().importProfile(target.getUniqueId(),a[3]);plugin.bossBars().update(target);sender.sendMessage(Component.text("已备份当前档并立即导入应用。",NamedTextColor.GREEN));}
      case "status"->sender.sendMessage(Component.text("schema="+p.schemaVersion+" UUID="+p.uuid+" updated="+DateTimeFormatter.ISO_INSTANT.format(p.updatedAt)+" 主线="+p.main.stage+" 儿童="+p.child.stage+" Boss="+p.child.bossStage+" 成就="+plugin.achievements().total(p)+"/40 称号="+plugin.achievements().title(p).name()+" 锁定="+p.writeBlocked,NamedTextColor.AQUA));
      default->throw new IllegalArgumentException("未知 profile 子命令");
    }
  }

  private void key(CommandSender sender,String[] a){if(a.length<3||!a[1].equalsIgnoreCase("grant"))throw new IllegalArgumentException("/vt key grant <player>");Player target=requirePlayer(a[2]);PlayerProfile p=requireProfile(target);p.portableKeyAuthorized=true;target.getInventory().addItem(plugin.items().key(target));plugin.profiles().save(p);sender.sendMessage(Component.text("已向 "+target.getName()+" 发放绑定钥匙。",NamedTextColor.GREEN));}
  private void child(CommandSender sender,String[] a){if(a.length<3)throw new IllegalArgumentException("/vt child <enable|disable|reset|status> <player>");Player target=requirePlayer(a[2]);PlayerProfile p=requireProfile(target);switch(a[1].toLowerCase()){case"enable"->p.child.enabled=true;case"disable"->p.child.enabled=false;case"reset"->{boolean enabled=p.child.enabled;p.child=new PlayerProfile.ChildRoute();p.child.enabled=enabled;p.child.stage=1;p.child.bossStage=1;p.childAuxiliaries.clear();p.selectedChildAuxiliary=0;}case"status"->{sender.sendMessage("儿童线 enabled="+p.child.enabled+" stage="+p.child.stage+" boss="+p.child.bossStage+" ascended="+p.child.ascended);return;}default->throw new IllegalArgumentException("未知 child 子命令");}plugin.profiles().save(p);plugin.bossBars().update(target);sender.sendMessage(Component.text("儿童线操作已应用。",NamedTextColor.GREEN));}
  private void penalty(CommandSender sender,String[] a)throws IOException{if(a.length<2)throw new IllegalArgumentException("/vt penalty <normal|mild|severe|extreme|status>");int level=switch(a[1].toLowerCase()){case"normal"->0;case"mild"->1;case"severe"->2;case"extreme"->3;case"status"->{sender.sendMessage("当前全局制裁等级："+plugin.serverState().state().penaltyLevel);yield-1;}default->throw new IllegalArgumentException("未知等级");};if(level>=0){plugin.serverState().setPenalty(level);Bukkit.broadcast(Component.text("VillageTrader 全局制裁等级已设为 "+level,NamedTextColor.RED));}}
  private void shop(CommandSender sender,String[] a){if(a.length<2||!a[1].equalsIgnoreCase("create")||!(sender instanceof Player p))throw new IllegalArgumentException("玩家执行 /vt shop create");sender.sendMessage(plugin.merchants().createAt(p.getLocation())?"已创建商店。":"此处未启用或160格内已有商店。");}
  private void nightVision(CommandSender sender,String[] a){if(a.length<3)throw new IllegalArgumentException("/vt nightvision <suspend|resume|status> <player>");Player target=requirePlayer(a[2]);PlayerProfile p=requireProfile(target);switch(a[1].toLowerCase()){case"suspend"->p.settings.put("nightVisionSuspended",true);case"resume"->p.settings.put("nightVisionSuspended",false);case"status"->{sender.sendMessage("nightVisionSuspended="+p.settings.getOrDefault("nightVisionSuspended",false));return;}default->throw new IllegalArgumentException("未知 nightvision 子命令");}plugin.profiles().save(p);}
  private Player requirePlayer(String name){Player p=Bukkit.getPlayerExact(name);if(p==null)throw new IllegalArgumentException("玩家必须在线："+name);return p;}
  private PlayerProfile requireProfile(Player p){PlayerProfile profile=plugin.profiles().get(p.getUniqueId());if(profile==null)throw new IllegalStateException("玩家档案未加载");return profile;}
  private void help(CommandSender s){s.sendMessage(Component.text("VillageTrader: /vt open；管理员：profile、key、child、penalty、shop、nightvision",NamedTextColor.GOLD));}
  @Override public List<String> onTabComplete(CommandSender s,Command c,String alias,String[] a){if(a.length==1)return filter(List.of("open","profile","key","child","penalty","shop","nightvision"),a[0]);if(a.length==2)return switch(a[0].toLowerCase()){case"profile"->filter(List.of("export","import","status"),a[1]);case"key"->filter(List.of("grant"),a[1]);case"child"->filter(List.of("enable","disable","reset","status"),a[1]);case"penalty"->filter(List.of("normal","mild","severe","extreme","status"),a[1]);case"shop"->filter(List.of("create"),a[1]);case"nightvision"->filter(List.of("suspend","resume","status"),a[1]);default->List.of();};if(a.length==3&&List.of("profile","key","child","nightvision").contains(a[0].toLowerCase()))return filter(Bukkit.getOnlinePlayers().stream().map(Player::getName).toList(),a[2]);return List.of();}
  private List<String> filter(List<String> source,String token){String q=token.toLowerCase();return source.stream().filter(v->v.toLowerCase().startsWith(q)).toList();}
}
