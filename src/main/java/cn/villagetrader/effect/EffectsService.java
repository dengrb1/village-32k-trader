package cn.villagetrader.effect;

import cn.villagetrader.VillageTraderPlugin;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.shop.UnlockPolicy;
import cn.villagetrader.storage.ProfileManager;
import cn.villagetrader.util.InventoryUtil;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
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
  public enum EquipmentCategory { ARMOR("护甲"), MELEE("近战"), TOOLS("工具"), RANGED("远程"), UTILITY("功能装备");
    private final String display; EquipmentCategory(String display) { this.display = display; } public String display() { return display; } }
  public enum EquipmentPiece {
    HELMET("头盔", EquipmentCategory.ARMOR), CHESTPLATE("胸甲", EquipmentCategory.ARMOR), LEGGINGS("护腿", EquipmentCategory.ARMOR), BOOTS("靴子", EquipmentCategory.ARMOR),
    SWORD("长剑", EquipmentCategory.MELEE), AXE("战斧", EquipmentCategory.MELEE), SPEAR("长矛", EquipmentCategory.MELEE), TRIDENT("三叉戟", EquipmentCategory.MELEE), MACE("重锤", EquipmentCategory.MELEE),
    FORTUNE_PICKAXE("时运镐", EquipmentCategory.TOOLS), SILK_PICKAXE("精准镐", EquipmentCategory.TOOLS), SHOVEL("战铲", EquipmentCategory.TOOLS), HOE("战锄", EquipmentCategory.TOOLS),
    BOW("长弓", EquipmentCategory.RANGED), CROSSBOW("连弩", EquipmentCategory.RANGED), SHIELD("守护盾", EquipmentCategory.UTILITY), ELYTRA("羽翼", EquipmentCategory.UTILITY);
    private final String display; private final EquipmentCategory category;
    EquipmentPiece(String display, EquipmentCategory category) { this.display = display; this.category = category; }
    public String display() { return display; } public EquipmentCategory category() { return category; }
  }

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
      String auxiliaryState = applyAuxiliary(player, profile);
      announceAuxiliaryState(player, profile, profile.child.enabled ? "child" : "main", auxiliaryState);
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

  /** Issues exactly one item from a previously purchased main-route pass. */
  public Result claimMainEquipment(Player player, int tier, EquipmentPiece piece) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null || !profile.mainEquipmentPasses.contains(tier)) return new Result(false, "尚未购买该主线装备通行证。");
    ItemStack item = mainPiece(player, tier, piece);
    if (item == null) return new Result(false, "此等级不提供该装备。");
    InventoryUtil.giveOrDrop(player, item);
    return new Result(true, "已免费补领 " + tier + " 级" + piece.display() + "。");
  }

  /** Issues exactly one item from a previously purchased guardian-route pass. */
  public Result claimChildEquipment(Player player, int tier, EquipmentPiece piece) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null || !profile.childEquipmentPasses.contains(tier)) return new Result(false, "尚未购买该守护装备通行证。");
    ItemStack item = childPiece(player, tier, piece);
    if (item == null) return new Result(false, "此守护等级不提供该装备。");
    InventoryUtil.giveOrDrop(player, item);
    return new Result(true, "已免费补领 " + tier + " 级守护" + piece.display() + "。");
  }

  public Map<EquipmentPiece, ItemStack> pieces(Player player, boolean child, int tier) {
    Map<EquipmentPiece, ItemStack> result = new LinkedHashMap<>();
    for (EquipmentPiece piece : EquipmentPiece.values()) {
      ItemStack item = child ? childPiece(player, tier, piece) : mainPiece(player, tier, piece);
      if (item != null) result.put(piece, item);
    }
    return result;
  }

  private ItemStack mainPiece(Player player, int tier, EquipmentPiece piece) {
    Material armor = tier == 5 ? Material.DIAMOND_HELMET : Material.NETHERITE_HELMET;
    Material weapon = tier == 5 ? Material.DIAMOND_SWORD : Material.NETHERITE_SWORD;
    Material tool = tier == 5 ? Material.DIAMOND_PICKAXE : Material.NETHERITE_PICKAXE;
    Material spear = tier == 5 ? Material.DIAMOND_SPEAR : Material.NETHERITE_SPEAR;
    String prefix = "「" + tier + "级」";
    return switch (piece) {
      case HELMET -> gear(player, armor, prefix + "神盔", "main_equipment", tier, Gear.ARMOR);
      case CHESTPLATE -> gear(player, tier == 5 ? Material.DIAMOND_CHESTPLATE : Material.NETHERITE_CHESTPLATE, prefix + "战甲", "main_equipment", tier, Gear.ARMOR);
      case LEGGINGS -> gear(player, tier == 5 ? Material.DIAMOND_LEGGINGS : Material.NETHERITE_LEGGINGS, prefix + "护腿", "main_equipment", tier, Gear.ARMOR);
      case BOOTS -> gear(player, tier == 5 ? Material.DIAMOND_BOOTS : Material.NETHERITE_BOOTS, prefix + "战靴", "main_equipment", tier, Gear.BOOTS);
      case SWORD -> gear(player, weapon, prefix + "长剑", "main_equipment", tier, Gear.SWORD);
      case AXE -> gear(player, tier == 5 ? Material.DIAMOND_AXE : Material.NETHERITE_AXE, prefix + "战斧", "main_equipment", tier, Gear.AXE);
      case SPEAR -> gear(player, spear, prefix + "破阵长矛", "main_equipment", tier, Gear.SPEAR);
      case TRIDENT -> gear(player, Material.TRIDENT, prefix + "战戟", "main_equipment", tier, Gear.TRIDENT);
      case MACE -> gear(player, Material.MACE, prefix + "重锤", "main_equipment", tier, Gear.MACE);
      case FORTUNE_PICKAXE -> gear(player, tool, prefix + "时运镐", "main_equipment", tier, Gear.TOOL);
      case SILK_PICKAXE -> gear(player, tool, prefix + "精准镐", "main_equipment", tier, Gear.SILK_TOOL);
      case SHOVEL -> gear(player, tier == 5 ? Material.DIAMOND_SHOVEL : Material.NETHERITE_SHOVEL, prefix + "战铲", "main_equipment", tier, Gear.TOOL);
      case HOE -> gear(player, tier == 5 ? Material.DIAMOND_HOE : Material.NETHERITE_HOE, prefix + "战锄", "main_equipment", tier, Gear.TOOL);
      case BOW -> gear(player, Material.BOW, prefix + "长弓", "main_equipment", tier, Gear.BOW);
      case CROSSBOW -> gear(player, Material.CROSSBOW, prefix + "连弩", "main_equipment", tier, Gear.CROSSBOW);
      case SHIELD -> gear(player, Material.SHIELD, prefix + "守护盾", "main_equipment", tier, Gear.SHIELD);
      case ELYTRA -> gear(player, Material.ELYTRA, prefix + "羽翼", "main_equipment", tier, Gear.ELYTRA);
    };
  }

  private ItemStack childPiece(Player player, int tier, EquipmentPiece piece) {
    Material material = tier <= 3 ? Material.IRON_SWORD : tier <= 10 ? Material.DIAMOND_SWORD : Material.NETHERITE_SWORD;
    Material armor = tier <= 3 ? Material.IRON_HELMET : tier <= 10 ? Material.DIAMOND_HELMET : Material.NETHERITE_HELMET;
    Material tool = tier <= 3 ? Material.IRON_PICKAXE : tier <= 10 ? Material.DIAMOND_PICKAXE : Material.NETHERITE_PICKAXE;
    Material spear = tier <= 3 ? Material.IRON_SPEAR : tier <= 10 ? Material.DIAMOND_SPEAR : Material.NETHERITE_SPEAR;
    String prefix = "「" + tier + "级守护」";
    return switch (piece) {
      case HELMET -> gear(player, armor, prefix + "铁盔", "child_equipment", tier, Gear.ARMOR);
      case CHESTPLATE -> gear(player, tier <= 3 ? Material.IRON_CHESTPLATE : tier <= 10 ? Material.DIAMOND_CHESTPLATE : Material.NETHERITE_CHESTPLATE, prefix + "战甲", "child_equipment", tier, Gear.ARMOR);
      case LEGGINGS -> gear(player, tier <= 3 ? Material.IRON_LEGGINGS : tier <= 10 ? Material.DIAMOND_LEGGINGS : Material.NETHERITE_LEGGINGS, prefix + "护腿", "child_equipment", tier, Gear.ARMOR);
      case BOOTS -> gear(player, tier <= 3 ? Material.IRON_BOOTS : tier <= 10 ? Material.DIAMOND_BOOTS : Material.NETHERITE_BOOTS, prefix + "战靴", "child_equipment", tier, Gear.BOOTS);
      case SWORD -> gear(player, material, prefix + "长剑", "child_equipment", tier, Gear.SWORD);
      case AXE -> gear(player, tier <= 3 ? Material.IRON_AXE : tier <= 10 ? Material.DIAMOND_AXE : Material.NETHERITE_AXE, prefix + "战斧", "child_equipment", tier, Gear.AXE);
      case SPEAR -> gear(player, spear, prefix + "守护长矛", "child_equipment", tier, Gear.SPEAR);
      case FORTUNE_PICKAXE -> gear(player, tool, prefix + "矿镐", "child_equipment", tier, Gear.TOOL);
      case SHOVEL -> gear(player, tier <= 3 ? Material.IRON_SHOVEL : tier <= 10 ? Material.DIAMOND_SHOVEL : Material.NETHERITE_SHOVEL, prefix + "战铲", "child_equipment", tier, Gear.TOOL);
      case HOE -> gear(player, tier <= 3 ? Material.IRON_HOE : tier <= 10 ? Material.DIAMOND_HOE : Material.NETHERITE_HOE, prefix + "战锄", "child_equipment", tier, Gear.TOOL);
      case BOW -> gear(player, Material.BOW, prefix + "长弓", "child_equipment", tier, Gear.BOW);
      case SHIELD -> gear(player, Material.SHIELD, prefix + "守护盾", "child_equipment", tier, Gear.SHIELD);
      default -> null;
    };
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
    enchant(meta, Enchantment.MENDING, 1);
    item.setItemMeta(meta);
    return item;
  }

  private void enchant(ItemMeta meta, Enchantment enchantment, int level) { meta.addEnchant(enchantment, Math.max(1, level), true); }
  private void give(Player player, ItemStack... stacks) { for (ItemStack stack : stacks) InventoryUtil.giveOrDrop(player, stack); }

  private String applyAuxiliary(Player player, PlayerProfile profile) {
    if (profile.child.enabled) {
      int id = profile.selectedChildAuxiliary;
      boolean registered = id != 0 && profile.childAuxiliaries.contains(id);
      boolean carried = registered && items.has(player, "child_aux", id);
      if (!carried) return auxiliaryStatus(registered, id != 0, false, false);
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
      return auxiliaryStatus(true, true, true, true);
    }
    int id = profile.selectedMainAuxiliary;
    boolean registered = id != 0 && profile.mainAuxiliaries.contains(id);
    boolean carried = registered && items.has(player, "main_aid", id);
    if (!carried) return auxiliaryStatus(registered, id != 0, false, false);
    boolean active = false;
    switch (id) {
      case 1 -> { effect(player, PotionEffectType.HASTE, 80, 0); active = true; }
      case 2 -> { if (player.getWorld().getEnvironment() == World.Environment.NETHER) { effect(player, PotionEffectType.FIRE_RESISTANCE, 80, 0); effect(player, PotionEffectType.RESISTANCE, 80, 0); active = true; } }
      case 3 -> { if (player.getWorld().getEnvironment() == World.Environment.THE_END) { effect(player, PotionEffectType.SLOW_FALLING, 80, 0); effect(player, PotionEffectType.REGENERATION, 80, 0); active = true; } }
      case 4 -> { if (!player.getWorld().getNearbyEntities(player.getLocation(), 64, 64, 64, entity -> entity.getType().name().contains("PILLAGER") || entity.getType().name().contains("VINDICATOR") || entity.getType().name().contains("RAVAGER")).isEmpty()) { effect(player, PotionEffectType.RESISTANCE, 80, 0); effect(player, PotionEffectType.REGENERATION, 80, 0); active = true; } }
      case 5 -> { effect(player, PotionEffectType.RESISTANCE, 80, 1); player.removePotionEffect(PotionEffectType.WITHER); active = true; }
      case 6 -> { if (player.getLocation().getBlock().getBiome().getKey().getKey().contains("deep_dark")) { effect(player, PotionEffectType.SPEED, 80, 1); effect(player, PotionEffectType.RESISTANCE, 80, 1); effect(player, PotionEffectType.REGENERATION, 80, 0); active = true; } }
      case 7 -> { if (player.getWorld().getEnvironment() == World.Environment.NORMAL) { effect(player, PotionEffectType.HASTE, 80, 1); effect(player, PotionEffectType.SLOW_FALLING, 80, 0); active = true; } }
      case 8 -> { effect(player, PotionEffectType.SPEED, 80, 0); effect(player, PotionEffectType.RESISTANCE, 80, 0); active = true; }
      default -> { }
    }
    return auxiliaryStatus(true, true, true, active);
  }

  private String auxiliaryStatus(boolean registered, boolean selected, boolean carried, boolean active) {
    return "登记=" + (registered ? "是" : "否") + "，选中=" + (selected ? "是" : "否") + "，携带=" + (carried ? "是" : "否") + "，生效=" + (active ? "是" : "否");
  }

  private void announceAuxiliaryState(Player player, PlayerProfile profile, String route, String state) {
    String key = "auxiliary." + route;
    String previous = profile.auxiliaryStates.put(key, state);
    if (state.equals(previous)) return;
    profiles.save(profile);
    player.sendActionBar(Component.text("辅助用品状态：" + state, NamedTextColor.AQUA));
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
