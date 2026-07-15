package cn.villagetrader.effect;

import cn.villagetrader.VillageTraderPlugin;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.shop.UnlockPolicy;
import cn.villagetrader.storage.ProfileManager;
import java.util.List;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Bukkit;
import org.bukkit.Material;
import org.bukkit.World;
import org.bukkit.enchantments.Enchantment;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.EventPriority;
import org.bukkit.event.Listener;
import org.bukkit.event.entity.EntityDamageEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.ItemMeta;
import org.bukkit.potion.PotionEffect;
import org.bukkit.potion.PotionEffectType;

public final class EffectsService implements Listener {
  private final VillageTraderPlugin plugin;
  private final ProfileManager profiles;
  private final ItemService items;

  public EffectsService(VillageTraderPlugin plugin, ProfileManager profiles, ItemService items) { this.plugin = plugin; this.profiles = profiles; this.items = items; }

  public void tick() {
    for (Player player : Bukkit.getOnlinePlayers()) {
      PlayerProfile p = profiles.get(player.getUniqueId());
      if (p == null || !plugin.isEnabledWorld(player.getWorld())) continue;
      if (p.child.enabled && wearsAnyMainEquipment(player)) {
        p.child.enabled = false; profiles.save(p);
        player.sendMessage(Component.text("检测到主线装备，儿童守护线已自动暂停。", NamedTextColor.YELLOW));
      }
      if (p.child.enabled && !p.settings.getOrDefault("nightVisionSuspended", false)) effect(player, PotionEffectType.NIGHT_VISION, 80, 0);
      applyAuxiliary(player, p);
      if (p.main.stage >= 7 && p.main.hardMode && fullSet(player, "main_equipment", 255)) {
        effect(player, PotionEffectType.RESISTANCE, 80, 3); effect(player, PotionEffectType.REGENERATION, 80, 4);
        effect(player, PotionEffectType.FIRE_RESISTANCE, 80, 0); effect(player, PotionEffectType.WATER_BREATHING, 80, 0);
        effect(player, PotionEffectType.STRENGTH, 80, 4); effect(player, PotionEffectType.SPEED, 80, 1);
      }
    }
  }

  public void giveEquipment(Player player, int tier) {
    PlayerProfile p = profiles.get(player.getUniqueId());
    if (p == null || !UnlockPolicy.equipment(p, tier)) { player.sendActionBar(Component.text("尚未解锁此装备。", NamedTextColor.RED)); return; }
    boolean child = tier == 128;
    String kind = child ? "child_equipment" : "main_equipment";
    Material[] types = {Material.NETHERITE_HELMET,Material.NETHERITE_CHESTPLATE,Material.NETHERITE_LEGGINGS,Material.NETHERITE_BOOTS,Material.NETHERITE_SWORD,Material.NETHERITE_AXE,Material.NETHERITE_PICKAXE,Material.NETHERITE_PICKAXE,Material.NETHERITE_SHOVEL,Material.NETHERITE_HOE,Material.BOW,Material.CROSSBOW,Material.SHIELD,Material.ELYTRA,Material.TRIDENT,Material.MACE};
    String[] names = {"神盔","战甲","护腿","战靴","长剑","战斧","时运镐","精准镐","战铲","战锄","长弓","连弩","守护盾","羽翼","战戟","重锤"};
    for (int i = 0; i < types.length; i++) {
      ItemStack item = items.create(types[i], "「" + tier + "级」" + names[i], kind, tier, player.getUniqueId(), List.of(Component.text("仅原领取者解锁套装能力", NamedTextColor.AQUA)));
      ItemMeta meta = item.getItemMeta(); meta.setUnbreakable(true);
      addEnchantments(meta, types[i], tier, i == 7); item.setItemMeta(meta); player.getInventory().addItem(item);
    }
    if(!child){p.main.equipmentTier=tier;profiles.save(p);}player.sendActionBar(Component.text("已领取 " + tier + " 级绑定装备。", NamedTextColor.GREEN));
  }

  private void addEnchantments(ItemMeta meta, Material type, int tier, boolean silk) {
    int level = Math.max(1, tier);
    if (type.name().contains("HELMET") || type.name().contains("CHESTPLATE") || type.name().contains("LEGGINGS") || type.name().contains("BOOTS")) meta.addEnchant(Enchantment.PROTECTION, level, true);
    if (type.name().contains("SWORD") || type.name().contains("AXE") || type == Material.TRIDENT || type == Material.MACE) meta.addEnchant(Enchantment.SHARPNESS, level, true);
    if (type.name().contains("PICKAXE") || type.name().contains("AXE") || type.name().contains("SHOVEL") || type.name().contains("HOE")) { meta.addEnchant(Enchantment.EFFICIENCY, level, true); meta.addEnchant(silk ? Enchantment.SILK_TOUCH : Enchantment.FORTUNE, silk ? 1 : level, true); }
    if (type == Material.BOW) meta.addEnchant(Enchantment.POWER, level, true);
    if (type == Material.CROSSBOW) meta.addEnchant(Enchantment.PIERCING, level, true);
    meta.addEnchant(Enchantment.UNBREAKING, level, true);
  }

  private void applyAuxiliary(Player player, PlayerProfile p) {
    if (p.child.enabled) {
      int id=p.selectedChildAuxiliary; if(id==0||!p.childAuxiliaries.contains(id)||!items.has(player,"child_aux",id))return;
      switch(id){case 1->effect(player,PotionEffectType.HASTE,80,0);case 2->{effect(player,PotionEffectType.HASTE,80,1);effect(player,PotionEffectType.FIRE_RESISTANCE,80,0);}case 3->{effect(player,PotionEffectType.SPEED,80,0);effect(player,PotionEffectType.SLOW_FALLING,80,0);}case 4->{effect(player,PotionEffectType.RESISTANCE,80,0);effect(player,PotionEffectType.REGENERATION,80,0);}case 6->{effect(player,PotionEffectType.RESISTANCE,80,1);effect(player,PotionEffectType.REGENERATION,80,1);effect(player,PotionEffectType.FIRE_RESISTANCE,80,0);effect(player,PotionEffectType.SLOW_FALLING,80,0);}case 7->{effect(player,PotionEffectType.RESISTANCE,80,1);effect(player,PotionEffectType.SLOW_FALLING,80,0);effect(player,PotionEffectType.STRENGTH,80,0);effect(player,PotionEffectType.REGENERATION,80,0);}case 8->{effect(player,PotionEffectType.RESISTANCE,80,2);effect(player,PotionEffectType.REGENERATION,80,1);player.removePotionEffect(PotionEffectType.WITHER);}case 9->{effect(player,PotionEffectType.SPEED,80,1);effect(player,PotionEffectType.RESISTANCE,80,3);effect(player,PotionEffectType.REGENERATION,80,2);effect(player,PotionEffectType.ABSORPTION,80,0);}default->{}}
    } else {
      int id=p.selectedMainAuxiliary;if(id==0||!p.mainAuxiliaries.contains(id)||!items.has(player,"main_aid",id))return;
      switch(id){case 1->effect(player,PotionEffectType.HASTE,80,0);case 2->{if(player.getWorld().getEnvironment()==World.Environment.NETHER){effect(player,PotionEffectType.FIRE_RESISTANCE,80,0);effect(player,PotionEffectType.RESISTANCE,80,0);}}case 3->{if(player.getWorld().getEnvironment()==World.Environment.THE_END){effect(player,PotionEffectType.SLOW_FALLING,80,0);effect(player,PotionEffectType.REGENERATION,80,0);}}case 4->{if(!player.getWorld().getNearbyEntities(player.getLocation(),64,64,64,e->e.getType().name().contains("PILLAGER")||e.getType().name().contains("VINDICATOR")||e.getType().name().contains("RAVAGER")).isEmpty()){effect(player,PotionEffectType.RESISTANCE,80,0);effect(player,PotionEffectType.REGENERATION,80,0);}}case 5->{effect(player,PotionEffectType.RESISTANCE,80,1);player.removePotionEffect(PotionEffectType.WITHER);}case 6->{if(player.getLocation().getBlock().getBiome().getKey().getKey().contains("deep_dark")){effect(player,PotionEffectType.SPEED,80,1);effect(player,PotionEffectType.RESISTANCE,80,1);effect(player,PotionEffectType.REGENERATION,80,0);}}default->{}}
    }
  }

  @EventHandler(ignoreCancelled=true,priority=EventPriority.HIGH)
  public void emergency(EntityDamageEvent event){
    if(!(event.getEntity() instanceof Player player))return; PlayerProfile p=profiles.get(player.getUniqueId()); if(p==null||!p.child.enabled||!p.child.ascended||!fullSet(player,"child_equipment",128))return;
    if(player.getHealth()-event.getFinalDamage()>4.0)return; long now=System.currentTimeMillis(); long until=p.cooldowns.getOrDefault("guardianEmergency",0L);if(now<until)return;
    event.setCancelled(true);player.setHealth(Math.min(player.getMaxHealth(),12.0));effect(player,PotionEffectType.REGENERATION,200,3);effect(player,PotionEffectType.RESISTANCE,200,4);p.cooldowns.put("guardianEmergency",now+60_000L);profiles.save(p);player.sendMessage(Component.text("守护升格急救已触发，60秒后可再次使用。",NamedTextColor.LIGHT_PURPLE));
  }

  private boolean fullSet(Player p,String kind,int tier){var a=p.getInventory().getArmorContents();return a.length==4&&items.matches(a[0],kind,tier,p.getUniqueId())&&items.matches(a[1],kind,tier,p.getUniqueId())&&items.matches(a[2],kind,tier,p.getUniqueId())&&items.matches(a[3],kind,tier,p.getUniqueId());}
  private boolean wearsAnyMainEquipment(Player p){for(ItemStack item:p.getInventory().getArmorContents())if(item!=null&&items.identity(item)!=null&&items.identity(item).kind().equals("main_equipment"))return true;return false;}
  private void effect(Player p,PotionEffectType type,int duration,int amplifier){p.addPotionEffect(new PotionEffect(type,duration,amplifier,true,false,false));}
}
