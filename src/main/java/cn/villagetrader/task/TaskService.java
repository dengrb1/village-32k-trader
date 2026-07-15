package cn.villagetrader.task;

import cn.villagetrader.VillageTraderPlugin;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.storage.ProfileManager;
import cn.villagetrader.util.InventoryUtil;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Material;
import org.bukkit.World;
import org.bukkit.entity.Blaze;
import org.bukkit.entity.EnderDragon;
import org.bukkit.entity.Enemy;
import org.bukkit.entity.Player;
import org.bukkit.entity.Skeleton;
import org.bukkit.entity.Warden;
import org.bukkit.entity.Wither;
import org.bukkit.entity.Zombie;
import org.bukkit.event.EventHandler;
import org.bukkit.event.EventPriority;
import org.bukkit.event.Listener;
import org.bukkit.event.block.BlockBreakEvent;
import org.bukkit.event.block.BlockPlaceEvent;
import org.bukkit.event.entity.EntityDeathEvent;
import org.bukkit.event.entity.EntityPickupItemEvent;
import org.bukkit.event.player.PlayerBedLeaveEvent;
import org.bukkit.event.player.PlayerChangedWorldEvent;
import org.bukkit.event.player.PlayerItemConsumeEvent;
import org.bukkit.event.raid.RaidFinishEvent;
import org.bukkit.event.inventory.CraftItemEvent;
import org.bukkit.event.inventory.FurnaceExtractEvent;

public final class TaskService implements Listener {
  private final VillageTraderPlugin plugin;
  private final ProfileManager profiles;
  private final ItemService items;

  public TaskService(VillageTraderPlugin plugin, ProfileManager profiles, ItemService items) {
    this.plugin = plugin;
    this.profiles = profiles;
    this.items = items;
  }

  public void activate(Player player, TaskDefinitions.Route route, int id) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null) return;
    PlayerProfile.Task task = task(profile, route);
    task.activate(id);
    player.getInventory().addItem(items.taskCard(player, routeName(route), id));
    refreshHeldGoals(player, profile);
    critical(profile);
  }

  public boolean submit(Player player, TaskDefinitions.Route route) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null) return false;
    PlayerProfile.Task task = task(profile, route);
    int expected = expectedStage(profile, route);
    if (task.activeId != expected || task.ownedCardId != expected) return fail(player, "当前任务尚未购买并激活。");
    refreshHeldGoals(player, profile);
    TaskDefinitions.Definition definition = TaskDefinitions.get(route, expected);
    List<String> missing = missing(task, definition);
    if (!missing.isEmpty()) return fail(player, "尚未完成：" + String.join("、", missing));
    if (!items.removeOne(player, itemKind(route), expected)) return fail(player, "缺少本人绑定的正确任务牌；辅助用品不能替代。");
    complete(profile, route, expected);
    player.sendMessage(Component.text("任务完成：" + definition.name(), NamedTextColor.GREEN));
    critical(profile);
    return true;
  }

  public void refreshHeldGoals(Player player, PlayerProfile profile) {
    if (profile.child.enabled && profile.child.task.activeId == 1) {
      set(profile.child.task, "logs", countLogs(player) >= 4 ? 1 : 0, 1);
      set(profile.child.task, "table", player.getInventory().contains(Material.CRAFTING_TABLE) ? 1 : 0, 1);
    }
    if (profile.child.enabled && profile.child.task.activeId == 4) {
      set(profile.child.task, "shield", player.getInventory().getItemInOffHand().getType() == Material.SHIELD ? 1 : 0, 1);
    }
    if (profile.child.enabled && profile.child.task.activeId == 5) {
      set(profile.child.task, "emeralds", player.getInventory().containsAtLeast(new org.bukkit.inventory.ItemStack(Material.EMERALD), 4) ? 1 : 0, 1);
    }
  }

  public void recordMerchantInteraction(Player player) {
    update(player, TaskDefinitions.Route.CHILD, 6, "merchant", 1, true);
  }

  public void recordChildPurchase(Player player) {
    update(player, TaskDefinitions.Route.CHILD, 5, "purchase", 1, true);
  }

  private void complete(PlayerProfile p, TaskDefinitions.Route route, int id) {
    switch (route) {
      case MAIN -> { p.main.stage = Math.min(7, p.main.stage + 1); p.main.equipmentTier = switch (id) { case 1 -> 5; case 2 -> 10; case 3 -> 20; case 4 -> 32; case 5 -> 64; default -> 255; }; p.equipmentTiers.add(p.main.equipmentTier); p.main.task.clear(); if (id == 6) p.main.hardMode = true; }
      case CHILD -> { p.child.stage = Math.min(7, p.child.stage + 1); p.child.task.clear(); }
      case BOSS -> { String mark = switch (id) { case 1 -> "dragon"; case 2 -> "wither"; default -> "warden"; }; p.child.bossMarks.add(mark); p.child.bossStage = Math.min(4, p.child.bossStage + 1); p.child.bossTask.clear(); }
      case ASCENSION -> { p.child.ascended = true; p.child.ascensionKeyOwned = false; p.equipmentTiers.add(128); }
    }
  }

  private List<String> missing(PlayerProfile.Task task, TaskDefinitions.Definition definition) {
    List<String> result = new ArrayList<>();
    if (definition == null) return List.of("未知任务定义");
    for (TaskDefinitions.Goal goal : definition.goals().values()) {
      int value = task.progress.getOrDefault(goal.key(), 0);
      if (value < goal.target()) result.add(goal.label() + " " + value + "/" + goal.target());
    }
    return result;
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void breakBlock(BlockBreakEvent event) {
    Material type = event.getBlock().getType();
    if (type == Material.DIAMOND_ORE || type == Material.DEEPSLATE_DIAMOND_ORE) {
      update(event.getPlayer(), TaskDefinitions.Route.MAIN, 1, "diamonds", 1, false);
      update(event.getPlayer(), TaskDefinitions.Route.CHILD, 5, "diamond", 1, false);
    } else if (type == Material.ANCIENT_DEBRIS) update(event.getPlayer(), TaskDefinitions.Route.MAIN, 2, "debris", 1, false);
    else if (type == Material.COBBLESTONE) update(event.getPlayer(), TaskDefinitions.Route.CHILD, 2, "cobble", 1, false);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void entityDeath(EntityDeathEvent event) {
    Player killer = event.getEntity().getKiller();
    if (killer == null) return;
    if (event.getEntity() instanceof Enemy) update(killer, TaskDefinitions.Route.MAIN, 1, "hostiles", 1, false);
    if (event.getEntity() instanceof Blaze) update(killer, TaskDefinitions.Route.MAIN, 2, "blazes", 1, false);
    if (event.getEntity() instanceof EnderDragon) { update(killer, TaskDefinitions.Route.MAIN, 3, "dragon", 1, true); update(killer, TaskDefinitions.Route.BOSS, 1, "dragon", 1, true); }
    if (event.getEntity() instanceof Wither) { update(killer, TaskDefinitions.Route.MAIN, 5, "wither", 1, true); update(killer, TaskDefinitions.Route.BOSS, 2, "wither", 1, true); }
    if (event.getEntity() instanceof Warden) { update(killer, TaskDefinitions.Route.MAIN, 6, "warden", 1, true); update(killer, TaskDefinitions.Route.BOSS, 3, "warden", 1, true); }
    if (event.getEntity() instanceof Zombie || event.getEntity() instanceof Skeleton) update(killer, TaskDefinitions.Route.CHILD, 4, "training_kills", 1, false);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void changedWorld(PlayerChangedWorldEvent event) {
    World.Environment env = event.getPlayer().getWorld().getEnvironment();
    if (env == World.Environment.NETHER) update(event.getPlayer(), TaskDefinitions.Route.MAIN, 2, "nether", 1, true);
    if (env == World.Environment.THE_END) update(event.getPlayer(), TaskDefinitions.Route.MAIN, 3, "end", 1, true);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void craft(CraftItemEvent event) {
    if (!(event.getWhoClicked() instanceof Player player)) return;
    if (event.getRecipe().getResult().getType() == Material.BEACON) update(player, TaskDefinitions.Route.MAIN, 5, "beacon", 1, true);
    if (event.getRecipe().getResult().getType() == Material.CRAFTING_TABLE) update(player, TaskDefinitions.Route.CHILD, 1, "table", 1, true);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void furnace(FurnaceExtractEvent event) {
    if (event.getItemType() == Material.IRON_INGOT) update(event.getPlayer(), TaskDefinitions.Route.CHILD, 2, "iron", 1, false);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void place(BlockPlaceEvent event) { if (event.getBlockPlaced().getType() == Material.TORCH || event.getBlockPlaced().getType() == Material.WALL_TORCH) update(event.getPlayer(), TaskDefinitions.Route.CHILD, 3, "torches", 1, false); }
  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void eat(PlayerItemConsumeEvent event) { if (event.getItem().getType().isEdible()) update(event.getPlayer(), TaskDefinitions.Route.CHILD, 3, "eat", 1, true); }
  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void sleep(PlayerBedLeaveEvent event) { if (event.getPlayer().getSleepTicks() >= 100) update(event.getPlayer(), TaskDefinitions.Route.CHILD, 3, "sleep", 1, true); }

  @EventHandler(priority = EventPriority.MONITOR)
  public void raid(RaidFinishEvent event) {
    for (Player winner : event.getWinners()) update(winner, TaskDefinitions.Route.MAIN, 4, "raid", 1, true);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void pickup(EntityPickupItemEvent event) {
    if (!(event.getEntity() instanceof Player player) || event.getItem().getItemStack().getType() != Material.TOTEM_OF_UNDYING) return;
    PlayerProfile p = profiles.get(player.getUniqueId());
    if (p != null && p.main.task.progress.getOrDefault("raid", 0) >= 1) update(player, TaskDefinitions.Route.MAIN, 4, "totem", 1, true);
  }

  private void update(Player player, TaskDefinitions.Route route, int taskId, String key, int amount, boolean critical) {
    PlayerProfile p = profiles.get(player.getUniqueId());
    if (p == null || !plugin.isEnabledWorld(player.getWorld())) return;
    if (route == TaskDefinitions.Route.MAIN && p.child.enabled) return;
    if ((route == TaskDefinitions.Route.CHILD || route == TaskDefinitions.Route.BOSS) && !p.child.enabled) return;
    PlayerProfile.Task task = task(p, route);
    if (task.activeId != taskId) return;
    TaskDefinitions.Definition definition = TaskDefinitions.get(route, taskId);
    TaskDefinitions.Goal goal = definition.goals().get(key);
    if (goal == null) return;
    set(task, key, task.progress.getOrDefault(key, 0) + amount, goal.target());
    p.touch(player.getName());
    if (route == TaskDefinitions.Route.BOSS && task.progress.getOrDefault(key, 0) >= goal.target()) {
      String name = definition.name();
      complete(p, route, taskId);
      player.sendMessage(Component.text(name + "完成，已永久获得 Boss 印记。", NamedTextColor.LIGHT_PURPLE));
      critical(p);
      return;
    }
    if (critical) critical(p);
  }

  private void set(PlayerProfile.Task task, String key, int value, int max) { task.progress.put(key, Math.max(0, Math.min(max, value))); }
  private void critical(PlayerProfile p) { profiles.save(p); }
  private boolean fail(Player player, String message) { player.sendActionBar(Component.text(message, NamedTextColor.RED)); return false; }
  private int expectedStage(PlayerProfile p, TaskDefinitions.Route route) { return switch (route) { case MAIN -> p.main.stage; case CHILD -> p.child.stage; case BOSS -> p.child.bossStage; case ASCENSION -> 1; }; }
  private PlayerProfile.Task task(PlayerProfile p, TaskDefinitions.Route route) { return switch (route) { case MAIN -> p.main.task; case CHILD -> p.child.task; case BOSS -> p.child.bossTask; case ASCENSION -> p.child.bossTask; }; }
  private String routeName(TaskDefinitions.Route route) { return switch (route) { case MAIN -> "main"; case CHILD -> "child"; case BOSS -> "boss"; case ASCENSION -> "ascension"; }; }
  private String itemKind(TaskDefinitions.Route route) { return switch (route) { case MAIN -> "main_quest"; case CHILD -> "child_quest"; case BOSS -> "child_boss_quest"; case ASCENSION -> "child_ascension_core"; }; }
  private int countLogs(Player player) { int total = 0; for (var item : player.getInventory().getContents()) if (item != null && item.getType().name().endsWith("_LOG")) total += item.getAmount(); return total; }
}
