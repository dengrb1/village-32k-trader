package cn.villagetrader.achievement;

import cn.villagetrader.VillageTraderPlugin;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.storage.ProfileManager;
import cn.villagetrader.util.InventoryUtil;
import java.util.List;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Material;
import org.bukkit.entity.Player;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.ItemMeta;

/** Owns one-time awards, category claims and title thresholds for all 40 achievements. */
public final class AchievementService {
  public record Result(boolean success, String message) {}
  public record Title(int level, String name, NamedTextColor color) {}

  private final ProfileManager profiles;
  private final ItemService items;

  public AchievementService(VillageTraderPlugin plugin, ProfileManager profiles, ItemService items) {
    this.profiles = profiles;
    this.items = items;
  }

  public boolean award(Player player, String id) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    AchievementDefinitions.Definition definition = AchievementDefinitions.get(id);
    if (profile == null || definition == null || !profile.achievements.add(id)) return false;
    profile.touch(player.getName());
    player.sendMessage(Component.text("[成就·" + definition.category().displayName() + "] " + definition.name(), color(definition.category())));
    grantFinalRewardIfNeeded(player, profile);
    profiles.save(profile);
    return true;
  }

  /** Used by JSON/data-pack migration; it never sends a toast-like chat message or grants duplicate loot. */
  public void awardSilently(PlayerProfile profile, String id) {
    if (profile != null && AchievementDefinitions.get(id) != null) profile.achievements.add(id);
  }

  public int total(PlayerProfile profile) {
    if (profile == null || profile.achievements == null) return 0;
    return (int) profile.achievements.stream().filter(id -> AchievementDefinitions.get(id) != null).count();
  }

  public int progress(PlayerProfile profile, AchievementDefinitions.Category category) {
    if (profile == null || profile.achievements == null) return 0;
    return (int) AchievementDefinitions.all(category).stream().filter(definition -> profile.achievements.contains(definition.id())).count();
  }

  public boolean has(PlayerProfile profile, String id) { return profile != null && profile.achievements != null && profile.achievements.contains(id); }

  public Title title(PlayerProfile profile) {
    int total = total(profile);
    if (total >= 40) return new Title(5, "终焉传奇", NamedTextColor.DARK_PURPLE);
    if (total >= 35) return new Title(4, "守护传说", NamedTextColor.LIGHT_PURPLE);
    if (total >= 25) return new Title(3, "传奇商会", NamedTextColor.GOLD);
    if (total >= 15) return new Title(2, "远征先锋", NamedTextColor.AQUA);
    if (total >= 5) return new Title(1, "村庄旅人", NamedTextColor.GREEN);
    return new Title(0, "旅程新人", NamedTextColor.GRAY);
  }

  public Result claim(Player player, AchievementDefinitions.Category category) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null) return new Result(false, "档案尚未加载。");
    if (progress(profile, category) < category.target()) {
      return new Result(false, category.displayName() + "类尚未集齐（" + category.target() + " 项）。");
    }
    String key = "category_" + category.key();
    if (!profile.achievementBundles.add(key)) return new Result(false, category.displayName() + "毕业补给已领取。");
    switch (category) {
      case STORY -> give(player, new ItemStack(Material.FIREWORK_ROCKET, 32), new ItemStack(Material.GOLDEN_APPLE, 16));
      case EXPLORE -> give(player, new ItemStack(Material.SPYGLASS), new ItemStack(Material.COMPASS), new ItemStack(Material.ENDER_PEARL, 16));
      case COMBAT -> give(player, new ItemStack(Material.TOTEM_OF_UNDYING, 2), new ItemStack(Material.GOLDEN_APPLE, 16));
      case TRADE -> give(player, new ItemStack(Material.EMERALD, 32), new ItemStack(Material.NETHERITE_INGOT, 2));
      case GUARDIAN -> give(player, new ItemStack(Material.DIAMOND, 16), new ItemStack(Material.TOTEM_OF_UNDYING));
    }
    profile.touch(player.getName());
    profiles.save(profile);
    return new Result(true, "已领取" + category.displayName() + "毕业补给。");
  }

  private void grantFinalRewardIfNeeded(Player player, PlayerProfile profile) {
    if (total(profile) < AchievementDefinitions.total() || !profile.achievementBundles.add("all_40")) return;
    ItemStack banner = items.create(Material.WHITE_BANNER, "终焉传奇", "achievement_banner", 40, player.getUniqueId(), List.of(
        Component.text("集齐 40 项村庄商人成就的证明", NamedTextColor.GRAY)));
    ItemMeta meta = banner.getItemMeta();
    meta.displayName(Component.text("终焉传奇", NamedTextColor.DARK_PURPLE));
    banner.setItemMeta(meta);
    give(player, banner);
    player.sendMessage(Component.text("[成就] 40/40 达成：终焉传奇称号与旗帜已解锁！", NamedTextColor.LIGHT_PURPLE));
  }

  private void give(Player player, ItemStack... stacks) {
    for (ItemStack stack : stacks) InventoryUtil.giveOrDrop(player, stack);
  }

  public static NamedTextColor color(AchievementDefinitions.Category category) {
    return switch (category) {
      case STORY -> NamedTextColor.GOLD;
      case EXPLORE -> NamedTextColor.AQUA;
      case COMBAT -> NamedTextColor.RED;
      case TRADE -> NamedTextColor.GREEN;
      case GUARDIAN -> NamedTextColor.LIGHT_PURPLE;
    };
  }
}
