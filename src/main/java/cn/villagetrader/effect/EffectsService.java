package cn.villagetrader.effect;

import cn.villagetrader.VillageTraderPlugin;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.shop.UnlockPolicy;
import cn.villagetrader.storage.ProfileManager;
import cn.villagetrader.util.InventoryUtil;
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

/** Equipment issuance and persistent route-specific effects. */
public final class EffectsService implements Listener {
  public record Result(boolean success, String message) {}

  private final VillageTraderPlugin plugin;
  private final ProfileManager profiles;
  private final ItemService items;

  public EffectsService(VillageTraderPlugin plugin, ProfileManager profiles, ItemService items) {
    this.plugin = plugin;
    this.profiles = profiles;
    this.items = items;
  }

  public void tick() {
    for (Player player : Bukkit.getOnlinePlayers()) {
      PlayerProfile profile = profiles.get(player.getUniqueId());
      if (profile == null || !plugin.isEnabledWorld(player.getWorld())) continue;
      if (profile.child.enabled && wearsAnyMainEquipment(player)) {
        profile.child.enabled = false;
        profiles.save(profile);
        player.sendMessage(Component.text("检测到主线装备，儿童守护线已自动暂停。", NamedTextColor.YELLOW));
      }
      if (profile.child.enabled && !profile.settings.getOrDefault("nightVisionSuspended", false)) effect(player, PotionEffectType.NIGHT_VISION, 80, 0);
      applyAuxiliary(player, profile);
      if (!profile.child.enabled && profile.main.hardMode && UnlockPolicy.mainEquipment(profile, 255) && fullSet(player, "main_equipment", 255)) {
        effect(player, PotionEffectType.RESISTANCE, 80, 3);
        effect(player, PotionEffectType.REGENERATION, 80, 4);
        effect(player, PotionEffectType.FIRE_RESISTANCE, 80, 0);
        effect(player, PotionEffectType.WATER_BREATHING, 80, 0);
        effect(player, PotionEffectType.STRENGTH, 80, 4);
        effect(player, PotionEffectType.SPEED, 80, 1);
      }
    }
  }

  /** Called only after ShopService has atomically collected the current exchange price. */
  public Result giveMainEquipment(Player player, int tier) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null || !UnlockPolicy.mainEquipment(profile, tier)) return new Result(false, "尚未解锁此主线装备。");
    giveMainSet(player, tier);
    profile.main.equipmentTier = tier;
    profile.equipmentTiers.add(tier);
    profile.touch(player.getName());
    profiles.save(profile);
    return new Result(true, "已兑换 " + tier + " 级绑定装备，含长矛。");
  }

  /** Called only after ShopService has atomically collected the child dirt price. */
  public Result giveChildEquipment(Player player, int tier) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null || !UnlockPolicy.childEquipment(profile, tier)) return new Result(false, "尚未解锁此守护装备。");
    giveChildSet(player, tier);
    profile.child.equipmentTier = tier;
    profile.touch(player.getName());
    profiles.save(profile);
    return new Result(true, "已兑换 " + tier + " 级绑定守护装备，含长矛。");
  }

  private void giveMainSet(Player player, int tier) {
    Material armor = tier == 5 ? Material.DIAMOND_HELMET : Material.NETHERITE_HELMET;
    Material chest = tier == 5 ? Material.DIAMOND_CHESTPLATE : Material.NETHERITE_CHESTPLATE;
    Material legs = tier == 5 ? Material.DIAMOND_LEGGINGS : Material.NETHERITE_LEGGINGS;
    Material boots = tier == 5 ? Material.DIAMOND_BOOTS : Material.NETHERITE_BOOTS;
    Material sword = tier == 5 ? Material.DIAMOND_SWORD : Material.NETHERITE_SWORD;
    Material axe = tier == 5 ? Material.DIAMOND_AXE : Material.NETHERITE_AXE;
    Material pickaxe = tier == 5 ? Material.DIAMOND_PICKAXE : Material.NETHERITE_PICKAXE;
    Material shovel = tier == 5 ? Material.DIAMOND_SHOVEL : Material.NETHERITE_SHOVEL;
    Material hoe = tier == 5 ? Material.DIAMOND_HOE : Material.NETHERITE_HOE;
    Material spear = tier == 5 ? Material.DIAMOND_SPEAR : Material.NETHERITE_SPEAR;
    String prefix = "「" + tier + "级」";
    give(player,
        gear(player, armor, prefix + "神盔", "main_equipment", tier, Gear.ARMOR),
        gear(player, chest, prefix + "战甲", "main_equipment", tier, Gear.ARMOR),
        gear(player, legs, prefix + "护腿", "main_equipment", tier, Gear.ARMOR),
        gear(player, boots, prefix + "战靴", "main_equipment", tier, Gear.BOOTS),
        gear(player, sword, prefix + "长剑", "main_equipment", tier, Gear.SWORD),
        gear(player, axe, prefix + "战斧", "main_equipment", tier, Gear.AXE),
        gear(player, pickaxe, prefix + "时运镐", "main_equipment", tier, Gear.TOOL),
        gear(player, pickaxe, prefix + "精准镐", "main_equipment", tier, Gear.SILK_TOOL),
        gear(player, shovel, prefix + "战铲", "main_equipment", tier, Gear.TOOL),
        gear(player, hoe, prefix + "战锄", "main_equipment", tier, Gear.TOOL),
        gear(player, Material.BOW, prefix + "长弓", "main_equipment", tier, Gear.BOW),
        gear(player, Material.CROSSBOW, prefix + "连弩", "main_equipment", tier, Gear.CROSSBOW),
        gear(player, Material.SHIELD, prefix + "守护盾", "main_equipment", tier, Gear.SHIELD),
        gear(player, Material.ELYTRA, prefix + "羽翼", "main_equipment", tier, Gear.ELYTRA),
        gear(player, Material.TRIDENT, prefix + "战戟", "main_equipment", tier, Gear.TRIDENT),
        gear(player, Material.MACE, prefix + "重锤", "main_equipment", tier, Gear.MACE),
        gear(player, spear, prefix + "破阵长矛", "main_equipment", tier, Gear.SPEAR));
  }

  private void giveChildSet(Player player, int tier) {
    Material material = switch (tier) {
      case 1, 3 -> Material.IRON_SWORD;
      case 5, 10 -> Material.DIAMOND_SWORD;
      default -> Material.NETHERITE_SWORD;
    };
    Material helmet = switch (tier) {
      case 1, 3 -> Material.IRON_HELMET;
      case 5, 10 -> Material.DIAMOND_HELMET;
      default -> Material.NETHERITE_HELMET;
    };
    Material chest = switch (tier) {
      case 1, 3 -> Material.IRON_CHESTPLATE;
      case 5, 10 -> Material.DIAMOND_CHESTPLATE;
      default -> Material.NETHERITE_CHESTPLATE;
    };
    Material legs = switch (tier) {
      case 1, 3 -> Material.IRON_LEGGINGS;
      case 5, 10 -> Material.DIAMOND_LEGGINGS;
      default -> Material.NETHERITE_LEGGINGS;
    };
    Material boots = switch (tier) {
      case 1, 3 -> Material.IRON_BOOTS;
      case 5, 10 -> Material.DIAMOND_BOOTS;
      default -> Material.NETHERITE_BOOTS;
    };
    Material axe = switch (tier) {
      case 1, 3 -> Material.IRON_AXE;
      case 5, 10 -> Material.DIAMOND_AXE;
      default -> Material.NETHERITE_AXE;
    };
    Material pickaxe = switch (tier) {
      case 1, 3 -> Material.IRON_PICKAXE;
      case 5, 10 -> Material.DIAMOND_PICKAXE;
      default -> Material.NETHERITE_PICKAXE;
    };
    Material shovel = switch (tier) {
      case 1, 3 -> Material.IRON_SHOVEL;
      case 5, 10 -> Material.DIAMOND_SHOVEL;
      default -> Material.NETHERITE_SHOVEL;
    };
    Material hoe = switch (tier) {
      case 1, 3 -> Material.IRON_HOE;
      case 5, 10 -> Material.DIAMOND_HOE;
      default -> Material.NETHERITE_HOE;
    };
    Material spear = switch (tier) {
      case 1, 3 -> Material.IRON_SPEAR;
      case 5, 10 -> Material.DIAMOND_SPEAR;
      default -> Material.NETHERITE_SPEAR;
    };
    String prefix = "「" + tier + "级守护」";
    give(player,
        gear(player, helmet, prefix + "铁盔", "child_equipment", tier, Gear.ARMOR),
        gear(player, chest, prefix + "战甲", "child_equipment", tier, Gear.ARMOR),
        gear(player, legs, prefix + "护腿", "child_equipment", tier, Gear.ARMOR),
        gear(player, boots, prefix + "战靴", "child_equipment", tier, Gear.BOOTS),
        gear(player, material, prefix + "长剑", "child_equipment", tier, Gear.SWORD),
        gear(player, spear, prefix + "守护长矛", "child_equipment", tier, Gear.SPEAR),
        gear(player, pickaxe, prefix + "矿镐", "child_equipment", tier, Gear.TOOL),
        gear(player, axe, prefix + "战斧", "child_equipment", tier, Gear.AXE),
        gear(player, shovel, prefix + "战铲", "child_equipment", tier, Gear.TOOL),
        gear(player, hoe, prefix + "战锄", "child_equipment", tier, Gear.TOOL),
        gear(player, Material.BOW, prefix + "长弓", "child_equipment", tier, Gear.BOW),
        gear(player, Material.SHIELD, prefix + "守护盾", "child_equipment", tier, Gear.SHIELD));
  }

  private ItemStack gear(Player player, Material type, String name, String kind, int tier, Gear gear) {
    ItemStack item = items.create(type, name, kind, tier, player.getUniqueId(), List.of(Component.text("仅原领取者解锁套装能力", NamedTextColor.AQUA)));
    ItemMeta meta = item.getItemMeta();
    meta.setUnbreakable(true);
    int level = Math.max(1, tier);
    switch (gear) {
      case ARMOR -> {
        enchant(meta, Enchantment.PROTECTION, level);
        enchant(meta, Enchantment.UNBREAKING, level);
      }
      case BOOTS -> {
        enchant(meta, Enchantment.PROTECTION, level);
        enchant(meta, Enchantment.FEATHER_FALLING, level);
        enchant(meta, Enchantment.UNBREAKING, level);
      }
      case SWORD -> {
        enchant(meta, Enchantment.SHARPNESS, level);
        enchant(meta, Enchantment.LOOTING, Math.max(1, level / 2));
        enchant(meta, Enchantment.UNBREAKING, level);
      }
      case SPEAR -> {
        enchant(meta, Enchantment.SHARPNESS, level);
        enchant(meta, Enchantment.LOOTING, Math.max(1, level / 2));
        enchant(meta, Enchantment.LUNGE, Math.max(1, (level + 1) / 2));
        enchant(meta, Enchantment.UNBREAKING, level);
      }
      case AXE -> {
        enchant(meta, Enchantment.SHARPNESS, level);
        enchant(meta, Enchantment.EFFICIENCY, level);
        enchant(meta, Enchantment.UNBREAKING, level);
      }
      case TOOL -> {
        enchant(meta, Enchantment.EFFICIENCY, level);
        enchant(meta, Enchantment.FORTUNE, Math.max(1, level / 2));
        enchant(meta, Enchantment.UNBREAKING, level);
      }
      case SILK_TOOL -> {
        enchant(meta, Enchantment.EFFICIENCY, level);
        enchant(meta, Enchantment.SILK_TOUCH, 1);
        enchant(meta, Enchantment.UNBREAKING, level);
      }
      case BOW -> {
        enchant(meta, Enchantment.POWER, level);
        enchant(meta, Enchantment.UNBREAKING, level);
        enchant(meta, Enchantment.INFINITY, 1);
      }
      case CROSSBOW -> {
        enchant(meta, Enchantment.PIERCING, level);
        enchant(meta, Enchantment.QUICK_CHARGE, level);
        enchant(meta, Enchantment.UNBREAKING, level);
      }
      case SHIELD, ELYTRA -> enchant(meta, Enchantment.UNBREAKING, level);
      case TRIDENT -> {
        enchant(meta, Enchantment.IMPALING, level);
        enchant(meta, Enchantment.LOYALTY, Math.min(5, level));
        enchant(meta, Enchantment.UNBREAKING, level);
      }
      case MACE -> {
        enchant(meta, Enchantment.DENSITY, level);
        enchant(meta, Enchantment.BREACH, level);
        enchant(meta, Enchantment.WIND_BURST, Math.max(1, level / 2));
        enchant(meta, Enchantment.UNBREAKING, level);
      }
    }
    item.setItemMeta(meta);
    return item;
  }

  private void enchant(ItemMeta meta, Enchantment enchantment, int level) { meta.addEnchant(enchantment, Math.max(1, level), true); }
  private void give(Player player, ItemStack... stacks) { for (ItemStack stack : stacks) InventoryUtil.giveOrDrop(player, stack); }

  private void applyAuxiliary(Player player, PlayerProfile profile) {
    if (profile.child.enabled) {
      int id = profile.selectedChildAuxiliary;
      if (id == 0 || !profile.childAuxiliaries.contains(id) || !items.has(player, "child_aux", id)) return;
      switch (id) {
        case 1 -> effect(player, PotionEffectType.HASTE, 80, 0);
        case 2 -> { effect(player, PotionEffectType.HASTE, 80, 1); effect(player, PotionEffectType.FIRE_RESISTANCE, 80, 0); }
        case 3 -> { effect(player, PotionEffectType.SPEED, 80, 0); effect(player, PotionEffectType.SLOW_FALLING, 80, 0); }
        case 4 -> { effect(player, PotionEffectType.RESISTANCE, 80, 0); effect(player, PotionEffectType.REGENERATION, 80, 0); }
        case 6 -> { effect(player, PotionEffectType.RESISTANCE, 80, 1); effect(player, PotionEffectType.REGENERATION, 80, 1); effect(player, PotionEffectType.FIRE_RESISTANCE, 80, 0); effect(player, PotionEffectType.SLOW_FALLING, 80, 0); }
        case 7 -> { effect(player, PotionEffectType.RESISTANCE, 80, 1); effect(player, PotionEffectType.SLOW_FALLING, 80, 0); effect(player, PotionEffectType.STRENGTH, 80, 0); effect(player, PotionEffectType.REGENERATION, 80, 0); }
        case 8 -> { effect(player, PotionEffectType.RESISTANCE, 80, 2); effect(player, PotionEffectType.REGENERATION, 80, 1); player.removePotionEffect(PotionEffectType.WITHER); }
        case 9 -> { effect(player, PotionEffectType.SPEED, 80, 1); effect(player, PotionEffectType.RESISTANCE, 80, 3); effect(player, PotionEffectType.REGENERATION, 80, 2); effect(player, PotionEffectType.ABSORPTION, 80, 0); }
        default -> { }
      }
      return;
    }
    int id = profile.selectedMainAuxiliary;
    if (id == 0 || !profile.mainAuxiliaries.contains(id) || !items.has(player, "main_aid", id)) return;
    switch (id) {
      case 1 -> effect(player, PotionEffectType.HASTE, 80, 0);
      case 2 -> { if (player.getWorld().getEnvironment() == World.Environment.NETHER) { effect(player, PotionEffectType.FIRE_RESISTANCE, 80, 0); effect(player, PotionEffectType.RESISTANCE, 80, 0); } }
      case 3 -> { if (player.getWorld().getEnvironment() == World.Environment.THE_END) { effect(player, PotionEffectType.SLOW_FALLING, 80, 0); effect(player, PotionEffectType.REGENERATION, 80, 0); } }
      case 4 -> { if (!player.getWorld().getNearbyEntities(player.getLocation(), 64, 64, 64, entity -> entity.getType().name().contains("PILLAGER") || entity.getType().name().contains("VINDICATOR") || entity.getType().name().contains("RAVAGER")).isEmpty()) { effect(player, PotionEffectType.RESISTANCE, 80, 0); effect(player, PotionEffectType.REGENERATION, 80, 0); } }
      case 5 -> { effect(player, PotionEffectType.RESISTANCE, 80, 1); player.removePotionEffect(PotionEffectType.WITHER); }
      case 6 -> { if (player.getLocation().getBlock().getBiome().getKey().getKey().contains("deep_dark")) { effect(player, PotionEffectType.SPEED, 80, 1); effect(player, PotionEffectType.RESISTANCE, 80, 1); effect(player, PotionEffectType.REGENERATION, 80, 0); } }
      default -> { }
    }
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.HIGH)
  public void emergency(EntityDamageEvent event) {
    if (!(event.getEntity() instanceof Player player)) return;
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null || !profile.child.enabled || !profile.child.ascended || !fullSet(player, "child_equipment", 128)) return;
    if (player.getHealth() - event.getFinalDamage() > 4.0) return;
    long now = System.currentTimeMillis();
    long until = profile.cooldowns.getOrDefault("guardianEmergency", 0L);
    if (now < until) return;
    event.setCancelled(true);
    player.setHealth(Math.min(player.getMaxHealth(), 12.0));
    effect(player, PotionEffectType.REGENERATION, 200, 3);
    effect(player, PotionEffectType.RESISTANCE, 200, 4);
    profile.cooldowns.put("guardianEmergency", now + 60_000L);
    profiles.save(profile);
    player.sendMessage(Component.text("守护升格急救已触发，60秒后可再次使用。", NamedTextColor.LIGHT_PURPLE));
  }

  private boolean fullSet(Player player, String kind, int tier) {
    ItemStack[] armor = player.getInventory().getArmorContents();
    return armor.length == 4 && items.matches(armor[0], kind, tier, player.getUniqueId()) && items.matches(armor[1], kind, tier, player.getUniqueId()) && items.matches(armor[2], kind, tier, player.getUniqueId()) && items.matches(armor[3], kind, tier, player.getUniqueId());
  }

  private boolean wearsAnyMainEquipment(Player player) {
    for (ItemStack item : player.getInventory().getArmorContents()) {
      ItemService.LegacyIdentity identity = items.identity(item);
      if (identity != null && identity.kind().equals("main_equipment")) return true;
    }
    return false;
  }

  private void effect(Player player, PotionEffectType type, int duration, int amplifier) { player.addPotionEffect(new PotionEffect(type, duration, amplifier, true, false, false)); }

  private enum Gear { ARMOR, BOOTS, SWORD, SPEAR, AXE, TOOL, SILK_TOOL, BOW, CROSSBOW, SHIELD, ELYTRA, TRIDENT, MACE }
}
