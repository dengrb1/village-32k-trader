package cn.villagetrader;

import cn.villagetrader.command.VillageTraderCommand;
import cn.villagetrader.achievement.AchievementService;
import cn.villagetrader.effect.EffectsService;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.merchant.MerchantService;
import cn.villagetrader.migration.LegacyMigrator;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.shop.ShopService;
import cn.villagetrader.storage.JsonStore;
import cn.villagetrader.storage.ProfileManager;
import cn.villagetrader.storage.ServerStateManager;
import cn.villagetrader.task.BossBarService;
import cn.villagetrader.task.TaskService;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import org.bukkit.Bukkit;
import org.bukkit.World;
import org.bukkit.plugin.java.JavaPlugin;

public final class VillageTraderPlugin extends JavaPlugin {
  private ProfileManager profiles;private ServerStateManager serverState;private ItemService items;private AchievementService achievements;private TaskService tasks;private BossBarService bossBars;private ShopService shop;private MerchantService merchants;private EffectsService effects;private LegacyMigrator legacy;private Set<String> enabledWorlds;
  @Override public void onEnable(){
    saveDefaultConfig();reloadWorlds();
    try{JsonStore json=new JsonStore();profiles=new ProfileManager(getDataFolder().toPath(),json,getLogger());serverState=new ServerStateManager(getDataFolder().toPath(),json);}catch(IOException ex){getLogger().severe("无法初始化安全档案存储: "+ex.getMessage());getServer().getPluginManager().disablePlugin(this);return;}
    items=new ItemService(this);achievements=new AchievementService(this,profiles,items);tasks=new TaskService(this,profiles,items,achievements);bossBars=new BossBarService(profiles,tasks);shop=new ShopService(this,profiles,serverState,items,tasks,achievements);effects=new EffectsService(this,profiles,items);merchants=new MerchantService(this,profiles,serverState,items,shop,tasks);legacy=new LegacyMigrator(items,serverState);if(serverState.createdNew())legacy.migrateServerState();
    var pm=getServer().getPluginManager();PlayerLifecycleListener lifecycle=new PlayerLifecycleListener(this);pm.registerEvents(lifecycle,this);pm.registerEvents(tasks,this);pm.registerEvents(shop,this);pm.registerEvents(merchants,this);pm.registerEvents(effects,this);
    VillageTraderCommand command=new VillageTraderCommand(this);var registered=getCommand("villagetrader");if(registered!=null){registered.setExecutor(command);registered.setTabCompleter(command);}
    long autosave=getConfig().getLong("autosave-ticks",9468);Bukkit.getScheduler().runTaskTimer(this,()->{for(PlayerProfile p:profiles.loadedProfiles())profiles.save(p);try{serverState.save();}catch(IOException ex){getLogger().severe("server-state 保存失败: "+ex.getMessage());}},autosave,autosave);
    Bukkit.getScheduler().runTaskTimer(this,bossBars::updateAll,10,getConfig().getLong("bossbar.update-ticks",10));Bukkit.getScheduler().runTaskTimer(this,effects::tick,20,20);Bukkit.getScheduler().runTaskTimer(this,merchants::tick,20,20);
    for(var player:Bukkit.getOnlinePlayers())lifecycle.load(player);
    getLogger().info("VillageTrader Paper 插件已启用；JSON 档案为唯一权威来源。");
  }
  @Override public void onDisable(){if(bossBars!=null)bossBars.close();if(profiles!=null){for(PlayerProfile p:profiles.loadedProfiles())profiles.save(p);profiles.close();}if(serverState!=null)try{serverState.save();}catch(IOException ex){getLogger().severe("停服保存 server-state 失败: "+ex.getMessage());}}
  private void reloadWorlds(){enabledWorlds=new HashSet<>(getConfig().getStringList("enabled-worlds"));if(enabledWorlds.isEmpty())for(World world:Bukkit.getWorlds())if(world.getEnvironment()==World.Environment.NORMAL){enabledWorlds.add(world.getName());break;}}
  public boolean isEnabledWorld(World world){return world!=null&&enabledWorlds.contains(world.getName());}
  public ProfileManager profiles(){return profiles;}public ServerStateManager serverState(){return serverState;}public ItemService items(){return items;}public AchievementService achievements(){return achievements;}public BossBarService bossBars(){return bossBars;}public ShopService shop(){return shop;}public MerchantService merchants(){return merchants;}public EffectsService effects(){return effects;}public LegacyMigrator legacy(){return legacy;}
}
