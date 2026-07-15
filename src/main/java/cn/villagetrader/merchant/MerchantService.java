package cn.villagetrader.merchant;

import cn.villagetrader.VillageTraderPlugin;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.model.ServerState;
import cn.villagetrader.shop.ShopService;
import cn.villagetrader.storage.ProfileManager;
import cn.villagetrader.storage.ServerStateManager;
import cn.villagetrader.task.TaskService;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Bukkit;
import org.bukkit.Location;
import org.bukkit.Material;
import org.bukkit.NamespacedKey;
import org.bukkit.StructureType;
import org.bukkit.World;
import org.bukkit.block.Block;
import org.bukkit.entity.Entity;
import org.bukkit.entity.Player;
import org.bukkit.entity.Villager;
import org.bukkit.event.EventHandler;
import org.bukkit.event.EventPriority;
import org.bukkit.event.Listener;
import org.bukkit.event.block.BlockBreakEvent;
import org.bukkit.event.entity.EntityDamageByEntityEvent;
import org.bukkit.event.entity.EntityDeathEvent;
import org.bukkit.event.player.PlayerInteractEntityEvent;
import org.bukkit.event.player.PlayerInteractEvent;
import org.bukkit.event.player.PlayerMoveEvent;
import org.bukkit.inventory.EquipmentSlot;
import org.bukkit.persistence.PersistentDataType;

@SuppressWarnings("deprecation")
public final class MerchantService implements Listener {
  private final VillageTraderPlugin plugin;
  private final ProfileManager profiles;
  private final ServerStateManager state;
  private final ItemService items;
  private final ShopService shop;
  private final TaskService tasks;
  private final NamespacedKey merchantKey;
  private final Set<UUID> respawning = new HashSet<>();
  private final Set<UUID> scannedChunks = new HashSet<>();

  public MerchantService(VillageTraderPlugin plugin, ProfileManager profiles, ServerStateManager state, ItemService items, ShopService shop, TaskService tasks) {
    this.plugin=plugin;this.profiles=profiles;this.state=state;this.items=items;this.shop=shop;this.tasks=tasks;merchantKey=new NamespacedKey(plugin,"merchant_shop");
  }

  public void tick() {
    for (ServerState.ShopRecord record : state.state().shops) {
      World world=Bukkit.getWorld(record.world);if(world==null)continue;
      if(!world.isChunkLoaded(((int)Math.floor(record.x))>>4,((int)Math.floor(record.z))>>4))continue;
      Entity entity=record.merchantUuid==null?null:Bukkit.getEntity(record.merchantUuid);
      if(entity instanceof Villager villager&&!villager.isDead()){if(!villager.getPersistentDataContainer().has(merchantKey))villager.getPersistentDataContainer().set(merchantKey,PersistentDataType.STRING,record.id.toString());continue;}
      if(!respawning.add(record.id))continue;
      Bukkit.getScheduler().runTaskLater(plugin,()->{try{state.increasePenalty();spawn(record);state.save();}catch(IOException ex){plugin.getLogger().severe("商人补回保存失败: "+ex.getMessage());}finally{respawning.remove(record.id);}},plugin.getConfig().getLong("merchant-respawn-ticks",100));
    }
  }

  @EventHandler(priority=EventPriority.MONITOR,ignoreCancelled=true)
  public void move(PlayerMoveEvent event){
    if(event.getTo()==null||event.getFrom().getChunk().equals(event.getTo().getChunk())||!plugin.isEnabledWorld(event.getTo().getWorld()))return;
    UUID marker=UUID.nameUUIDFromBytes((event.getTo().getWorld().getUID()+":"+event.getTo().getChunk().getX()+":"+event.getTo().getChunk().getZ()).getBytes(java.nio.charset.StandardCharsets.UTF_8));
    if(!scannedChunks.add(marker))return; Bukkit.getScheduler().runTask(plugin,()->scan(event.getPlayer()));
  }

  public boolean createAt(Location origin) {
    if (!plugin.isEnabledWorld(origin.getWorld()) || duplicate(origin)) return false;
    Location base=surface(origin.clone().add(10,0,0));
    ServerState.ShopRecord record=new ServerState.ShopRecord();record.world=base.getWorld().getName();record.x=base.getX()+4.5;record.y=base.getY()+1;record.z=base.getZ()+4.5;
    if(plugin.getConfig().getBoolean("build-shop-house",true)){buildHouse(base);record.houseBuilt=true;}
    state.state().shops.add(record);spawn(record);try{state.save();}catch(IOException ex){plugin.getLogger().severe(ex.getMessage());}return true;
  }

  private void scan(Player player){
    int radius=plugin.getConfig().getInt("village-scan-radius",32);
    var result=player.getWorld().locateNearestStructure(player.getLocation(),StructureType.VILLAGE,radius,false);
    if(result!=null&&result.distanceSquared(player.getLocation())<=radius*radius)createAt(player.getLocation());
  }

  private boolean duplicate(Location location){int radius=plugin.getConfig().getInt("shop-duplicate-radius",160);double max=radius*radius;for(var r:state.state().shops)if(r.world.equals(location.getWorld().getName())&&new Location(location.getWorld(),r.x,r.y,r.z).distanceSquared(location)<=max)return true;return false;}
  private Location surface(Location location){int y=location.getWorld().getHighestBlockYAt(location);return new Location(location.getWorld(),location.getBlockX(),y,location.getBlockZ());}
  private void buildHouse(Location base){World w=base.getWorld();for(int x=0;x<9;x++)for(int z=0;z<9;z++){w.getBlockAt(base.getBlockX()+x,base.getBlockY(),base.getBlockZ()+z).setType(Material.COBBLESTONE,false);for(int y=1;y<=4;y++){Block b=w.getBlockAt(base.getBlockX()+x,base.getBlockY()+y,base.getBlockZ()+z);boolean wall=x==0||x==8||z==0||z==8;b.setType(wall?Material.OAK_PLANKS:Material.AIR,false);}w.getBlockAt(base.getBlockX()+x,base.getBlockY()+5,base.getBlockZ()+z).setType(Material.OAK_PLANKS,false);}w.getBlockAt(base.getBlockX()+4,base.getBlockY()+1,base.getBlockZ()).setType(Material.OAK_DOOR,false);w.getBlockAt(base.getBlockX()+4,base.getBlockY()+2,base.getBlockZ()).setType(Material.OAK_DOOR,false);w.getBlockAt(base.getBlockX()+4,base.getBlockY()+1,base.getBlockZ()+4).setType(Material.LANTERN,false);}
  private void spawn(ServerState.ShopRecord record){World world=Bukkit.getWorld(record.world);if(world==null)return;Location at=new Location(world,record.x,record.y,record.z);Villager v=world.spawn(at,Villager.class,entity->{entity.customName(Component.text("成长商店",NamedTextColor.GOLD));entity.setCustomNameVisible(true);entity.setPersistent(true);entity.setRemoveWhenFarAway(false);entity.setAI(false);entity.setProfession(Villager.Profession.NITWIT);entity.getPersistentDataContainer().set(merchantKey,PersistentDataType.STRING,record.id.toString());});record.merchantUuid=v.getUniqueId();}

  @EventHandler(ignoreCancelled=true)
  public void interact(PlayerInteractEntityEvent event){if(event.getHand()!=EquipmentSlot.HAND||!(event.getRightClicked() instanceof Villager villager)||!villager.getPersistentDataContainer().has(merchantKey))return;event.setCancelled(true);tasks.recordMerchantInteraction(event.getPlayer());shop.open(event.getPlayer());}
  @EventHandler(ignoreCancelled=true)
  public void key(PlayerInteractEvent event){if(event.getHand()!=EquipmentSlot.HAND||!event.getAction().isRightClick()||!items.matches(event.getItem(),"portable_key",1,event.getPlayer().getUniqueId()))return;PlayerProfile p=profiles.get(event.getPlayer().getUniqueId());event.setCancelled(true);if(p==null||!p.portableKeyAuthorized){event.getPlayer().sendActionBar(Component.text("此钥匙未授权给你，转交不能转移权限。",NamedTextColor.RED));return;}shop.open(event.getPlayer());}
  @EventHandler(priority=EventPriority.MONITOR)
  public void death(EntityDeathEvent event){if(event.getEntity() instanceof Villager v&&v.getPersistentDataContainer().has(merchantKey)){event.getDrops().clear();tick();}}
  @EventHandler(ignoreCancelled=true)
  public void protectHouse(BlockBreakEvent event){for(var r:state.state().shops){if(!r.world.equals(event.getBlock().getWorld().getName()))continue;Location c=new Location(event.getBlock().getWorld(),r.x,r.y,r.z);if(c.distanceSquared(event.getBlock().getLocation())<=8*8&&!event.getPlayer().hasPermission("villagetrader.admin")){event.setCancelled(true);event.getPlayer().sendActionBar(Component.text("商店建筑受到保护。",NamedTextColor.RED));return;}}}
  @EventHandler(ignoreCancelled=true)
  public void merchantDamage(EntityDamageByEntityEvent event){if(event.getEntity() instanceof Villager v&&v.getPersistentDataContainer().has(merchantKey)&&event.getDamager() instanceof Player p&&!p.hasPermission("villagetrader.admin")){/* 保留原玩法：允许击杀，但明确风险。 */p.sendActionBar(Component.text("攻击成长商人会提高全局黑市制裁。",NamedTextColor.RED));}}
}
