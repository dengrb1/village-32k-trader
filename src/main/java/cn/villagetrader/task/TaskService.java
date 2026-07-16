package cn.villagetrader.task;

import cn.villagetrader.VillageTraderPlugin;
import cn.villagetrader.achievement.AchievementService;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.storage.ProfileManager;
import cn.villagetrader.util.InventoryUtil;
import java.util.ArrayList;
import java.util.List;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Material;
import org.bukkit.StructureType;
import org.bukkit.World;
import org.bukkit.generator.structure.Structure;
import org.bukkit.entity.Enemy;
import org.bukkit.entity.EntityType;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.EventPriority;
import org.bukkit.event.Listener;
import org.bukkit.event.block.Action;
import org.bukkit.event.block.BlockBreakEvent;
import org.bukkit.event.block.BlockPlaceEvent;
import org.bukkit.event.entity.EntityDeathEvent;
import org.bukkit.event.entity.EntityPickupItemEvent;
import org.bukkit.event.inventory.CraftItemEvent;
import org.bukkit.event.inventory.FurnaceExtractEvent;
import org.bukkit.event.player.PlayerBedLeaveEvent;
import org.bukkit.event.player.PlayerChangedWorldEvent;
import org.bukkit.event.player.PlayerInteractEvent;
import org.bukkit.event.player.PlayerItemConsumeEvent;
import org.bukkit.event.player.PlayerMoveEvent;
import org.bukkit.event.raid.RaidFinishEvent;
import org.bukkit.inventory.ItemStack;

/** Event-backed progression for both routes. Only an active, owned task can receive credit. */
public final class TaskService implements Listener {
  public record Result(boolean success, String message) {}

  private final VillageTraderPlugin plugin;
  private final ProfileManager profiles;
  private final ItemService items;
  private final AchievementService achievements;

  public TaskService(VillageTraderPlugin plugin, ProfileManager profiles, ItemService items, AchievementService achievements) {
    this.plugin = plugin;
    this.profiles = profiles;
    this.items = items;
    this.achievements = achievements;
  }

  public Result activate(Player player, TaskDefinitions.Route route, int id) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    TaskDefinitions.Definition definition = TaskDefinitions.get(route, id);
    if (profile == null || definition == null) return new Result(false, "当前任务定义不可用。");
    PlayerProfile.Task task = task(profile, route);
    if (task.activeId != 0 || task.ownedCardId != 0) return new Result(false, "已有任务处于激活或持有状态。");
    task.activate(id);
    InventoryUtil.giveOrDrop(player, items.taskCard(player, routeName(route), id));
    refreshHeldGoals(player, profile);
    profile.touch(player.getName());
    if (route == TaskDefinitions.Route.MAIN && id == 1) achievements.award(player, "trade_01");
    profiles.save(profile);
    return new Result(true, "已激活「" + definition.name() + "」。从现在开始记录目标。");
  }

  public Result submit(Player player, TaskDefinitions.Route route) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null) return new Result(false, "档案尚未加载。");
    PlayerProfile.Task task = task(profile, route);
    int expected = expectedStage(profile, route);
    if (task.activeId != expected || task.ownedCardId != expected) return new Result(false, "当前任务尚未购买并激活。");
    TaskDefinitions.Definition definition = TaskDefinitions.get(route, expected);
    if (definition == null) return new Result(false, "当前路线已没有可提交的普通任务。");
    refreshHeldGoals(player, profile);
    List<String> missing = missing(task, definition);
    if (!missing.isEmpty()) return new Result(false, "尚未完成：" + String.join("、", missing));
    if (!items.removeOne(player, itemKind(route), expected)) return new Result(false, "缺少本人绑定的正确任务牌；辅助用品不能替代。");
    complete(player, profile, route, expected);
    profile.touch(player.getName());
    profiles.save(profile);
    return new Result(true, "任务完成：「" + definition.name() + "」；" + completionSummary(route, expected));
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
      set(profile.child.task, "emeralds", player.getInventory().containsAtLeast(new ItemStack(Material.EMERALD), 4) ? 1 : 0, 1);
    }
  }

  public void recordMerchantInteraction(Player player) { update(player, TaskDefinitions.Route.CHILD, 6, "merchant", 1, true); }
  public void recordChildPurchase(Player player) { update(player, TaskDefinitions.Route.CHILD, 5, "purchase", 1, true); }

  private void complete(Player player, PlayerProfile p, TaskDefinitions.Route route, int id) {
    switch (route) {
      case MAIN -> completeMain(player, p, id);
      case CHILD -> {
        p.child.stage = Math.min(7, p.child.stage + 1);
        p.child.task.clear();
        if (id == 1) achievements.award(player, "guardian_01");
        if (id == 3) achievements.award(player, "guardian_02");
        if (id == 6) achievements.award(player, "guardian_03");
      }
      case BOSS -> {
        String mark = switch (id) { case 1 -> "dragon"; case 2 -> "wither"; default -> "warden"; };
        p.child.bossMarks.add(mark);
        p.child.bossStage = Math.min(4, p.child.bossStage + 1);
        p.child.bossTask.clear();
        achievements.award(player, "guardian_0" + (id + 3));
      }
      case ASCENSION -> {
        p.child.ascended = true;
        p.child.ascensionKeyOwned = false;
        p.equipmentTiers.add(128);
        achievements.award(player, "guardian_07");
      }
    }
  }

  private void completeMain(Player player, PlayerProfile p, int id) {
    p.main.stage = id >= 10 ? 11 : id + 1;
    p.main.task.clear();
    int equipmentTier = switch (id) {
      case 1 -> 5;
      case 2 -> 10;
      case 5 -> 20;
      case 6 -> 32;
      case 8 -> 64;
      case 10 -> 255;
      default -> 0;
    };
    if (equipmentTier > 0) p.equipmentTiers.add(equipmentTier);
    giveMainReward(player, id);
    achievements.award(player, "story_" + twoDigits(id));
    switch (id) {
      case 2 -> { achievements.award(player, "explore_01"); achievements.award(player, "combat_01"); }
      case 3 -> { achievements.award(player, "explore_02"); achievements.award(player, "combat_02"); }
      case 4 -> { achievements.award(player, "explore_03"); achievements.award(player, "combat_03"); }
      case 5 -> { achievements.award(player, "explore_04"); achievements.award(player, "combat_04"); }
      case 6 -> achievements.award(player, "combat_05");
      case 7 -> { achievements.award(player, "explore_05"); achievements.award(player, "combat_06"); }
      case 8 -> { achievements.award(player, "explore_06"); achievements.award(player, "combat_07"); }
      case 9 -> { achievements.award(player, "explore_07"); achievements.award(player, "combat_08"); }
      case 10 -> achievements.award(player, "explore_08");
      default -> { }
    }
  }

  private void giveMainReward(Player player, int id) {
    switch (id) {
      case 1 -> give(player, new ItemStack(Material.BREAD, 24), new ItemStack(Material.TORCH, 48));
      case 2 -> give(player, new ItemStack(Material.DIAMOND, 8), new ItemStack(Material.IRON_INGOT, 16), new ItemStack(Material.COAL, 32));
      case 3 -> { give(player, new ItemStack(Material.OBSIDIAN, 8)); player.addPotionEffect(new org.bukkit.potion.PotionEffect(org.bukkit.potion.PotionEffectType.FIRE_RESISTANCE, 24_000, 0, true, false, false)); }
      case 4 -> { give(player, new ItemStack(Material.HEART_OF_THE_SEA), new ItemStack(Material.NAUTILUS_SHELL, 8)); player.addPotionEffect(new org.bukkit.potion.PotionEffect(org.bukkit.potion.PotionEffectType.WATER_BREATHING, 24_000, 0, true, false, false)); }
      case 5 -> { give(player, new ItemStack(Material.ENDER_PEARL, 16)); player.addPotionEffect(new org.bukkit.potion.PotionEffect(org.bukkit.potion.PotionEffectType.SLOW_FALLING, 24_000, 0, true, false, false)); }
      case 6 -> give(player, new ItemStack(Material.TOTEM_OF_UNDYING, 2), new ItemStack(Material.EMERALD, 16), new ItemStack(Material.GOLDEN_APPLE, 8));
      case 7 -> give(player, new ItemStack(Material.TRIAL_KEY, 4), new ItemStack(Material.WIND_CHARGE, 16), new ItemStack(Material.GOLDEN_APPLE, 8));
      case 8 -> give(player, new ItemStack(Material.NETHERITE_INGOT, 4), new ItemStack(Material.ENCHANTED_GOLDEN_APPLE), new ItemStack(Material.OBSIDIAN, 16));
      case 9 -> give(player, new ItemStack(Material.ECHO_SHARD, 16), new ItemStack(Material.SCULK_CATALYST, 2), new ItemStack(Material.TOTEM_OF_UNDYING, 2));
      case 10 -> {
        give(player, new ItemStack(Material.FIREWORK_ROCKET, 64), new ItemStack(Material.ENCHANTED_GOLDEN_APPLE, 2));
        InventoryUtil.giveOrDrop(player, items.create(Material.WHITE_BANNER, "终焉传奇旗帜", "main_final_banner", 10, player.getUniqueId(), List.of(
            Component.text("完成十章主线的证明", NamedTextColor.GRAY))));
      }
      default -> { }
    }
  }

  private List<String> missing(PlayerProfile.Task task, TaskDefinitions.Definition definition) {
    List<String> result = new ArrayList<>();
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
      update(event.getPlayer(), TaskDefinitions.Route.MAIN, 2, "diamonds", 1, false);
      update(event.getPlayer(), TaskDefinitions.Route.CHILD, 5, "diamond", 1, false);
    } else if (type == Material.ANCIENT_DEBRIS) update(event.getPlayer(), TaskDefinitions.Route.MAIN, 3, "debris", 1, false);
    else if (type == Material.REDSTONE_ORE || type == Material.DEEPSLATE_REDSTONE_ORE) update(event.getPlayer(), TaskDefinitions.Route.MAIN, 2, "redstone", 1, false);
    else if (type == Material.COBBLESTONE) update(event.getPlayer(), TaskDefinitions.Route.CHILD, 2, "cobble", 1, false);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void entityDeath(EntityDeathEvent event) {
    Player killer = event.getEntity().getKiller();
    if (killer == null) return;
    if (event.getEntity() instanceof Enemy) update(killer, TaskDefinitions.Route.MAIN, 2, "hostiles", 1, false);
    switch (event.getEntity().getType()) {
      case BLAZE -> update(killer, TaskDefinitions.Route.MAIN, 3, "blazes", 1, false);
      case PIGLIN -> update(killer, TaskDefinitions.Route.MAIN, 3, "piglins", 1, false);
      case ELDER_GUARDIAN -> update(killer, TaskDefinitions.Route.MAIN, 4, "elder_guardian", 1, true);
      case ENDER_DRAGON -> {
        update(killer, TaskDefinitions.Route.MAIN, 5, "dragon", 1, true);
        update(killer, TaskDefinitions.Route.MAIN, 10, "dragon", 1, true);
        update(killer, TaskDefinitions.Route.BOSS, 1, "dragon", 1, true);
      }
      case BREEZE -> update(killer, TaskDefinitions.Route.MAIN, 7, "breezes", 1, false);
      case BOGGED -> update(killer, TaskDefinitions.Route.MAIN, 7, "bogged", 1, false);
      case RAVAGER -> update(killer, TaskDefinitions.Route.MAIN, 6, "ravager", 1, true);
      case WITHER -> {
        update(killer, TaskDefinitions.Route.MAIN, 8, "wither", 1, true);
        update(killer, TaskDefinitions.Route.BOSS, 2, "wither", 1, true);
      }
      case WARDEN -> {
        update(killer, TaskDefinitions.Route.MAIN, 9, "warden", 1, true);
        update(killer, TaskDefinitions.Route.BOSS, 3, "warden", 1, true);
      }
      case ZOMBIE, SKELETON -> update(killer, TaskDefinitions.Route.CHILD, 4, "training_kills", 1, false);
      default -> { }
    }
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void changedWorld(PlayerChangedWorldEvent event) {
    World.Environment environment = event.getPlayer().getWorld().getEnvironment();
    if (environment == World.Environment.NETHER) update(event.getPlayer(), TaskDefinitions.Route.MAIN, 3, "nether", 1, true);
    if (environment == World.Environment.THE_END) update(event.getPlayer(), TaskDefinitions.Route.MAIN, 5, "end", 1, true);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void craft(CraftItemEvent event) {
    if (!(event.getWhoClicked() instanceof Player player)) return;
    Material result = event.getRecipe().getResult().getType();
    if (result == Material.CRAFTING_TABLE) {
      update(player, TaskDefinitions.Route.MAIN, 1, "crafting_table", 1, true);
      update(player, TaskDefinitions.Route.CHILD, 1, "table", 1, true);
    }
    if (result == Material.CONDUIT) update(player, TaskDefinitions.Route.MAIN, 4, "conduit", 1, true);
    if (result == Material.BEACON) update(player, TaskDefinitions.Route.MAIN, 8, "beacon", 1, true);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void furnace(FurnaceExtractEvent event) {
    if (event.getItemType() == Material.IRON_INGOT) update(event.getPlayer(), TaskDefinitions.Route.MAIN, 1, "smelt_iron", event.getItemAmount(), false);
    if (event.getItemType() == Material.IRON_INGOT) update(event.getPlayer(), TaskDefinitions.Route.CHILD, 2, "iron", 1, false);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void place(BlockPlaceEvent event) {
    if (event.getBlockPlaced().getType() == Material.TORCH || event.getBlockPlaced().getType() == Material.WALL_TORCH) update(event.getPlayer(), TaskDefinitions.Route.CHILD, 3, "torches", 1, false);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void eat(PlayerItemConsumeEvent event) {
    if (event.getItem().getType().isEdible()) update(event.getPlayer(), TaskDefinitions.Route.CHILD, 3, "eat", 1, true);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void sleep(PlayerBedLeaveEvent event) {
    if (event.getPlayer().getSleepTicks() < 100) return;
    update(event.getPlayer(), TaskDefinitions.Route.MAIN, 1, "sleep", 1, true);
    update(event.getPlayer(), TaskDefinitions.Route.CHILD, 3, "sleep", 1, true);
  }

  @EventHandler(priority = EventPriority.MONITOR)
  public void raid(RaidFinishEvent event) {
    for (Player winner : event.getWinners()) update(winner, TaskDefinitions.Route.MAIN, 6, "raid", 1, true);
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void pickup(EntityPickupItemEvent event) {
    if (!(event.getEntity() instanceof Player player)) return;
    Material type = event.getItem().getItemStack().getType();
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (type == Material.TOTEM_OF_UNDYING && profile != null && profile.main.task.progress.getOrDefault("raid", 0) >= 1) {
      update(player, TaskDefinitions.Route.MAIN, 6, "totem", 1, true);
    }
    if (type == Material.ECHO_SHARD) update(player, TaskDefinitions.Route.MAIN, 9, "echo_shards", event.getItem().getItemStack().getAmount(), false);
    if (type == Material.WITHER_SKELETON_SKULL) update(player, TaskDefinitions.Route.MAIN, 8, "wither_skulls", event.getItem().getItemStack().getAmount(), false);
    if (type == Material.DRAGON_BREATH) update(player, TaskDefinitions.Route.MAIN, 10, "dragon_breath", event.getItem().getItemStack().getAmount(), false);
  }

  /**
   * Structure discovery is checked only while the matching commissioned task
   * is active.  A short loaded-chunk search avoids granting credit merely for
   * using an unrelated teleport or a locate command.
   */
  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void discoverStructure(PlayerMoveEvent event) {
    if (event.getTo() == null || event.getFrom().getChunk().equals(event.getTo().getChunk())) return;
    Player player = event.getPlayer();
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null || profile.child.enabled || !plugin.isEnabledWorld(player.getWorld())) return;
    if (profile.main.task.activeId == 4 && near(player, StructureType.OCEAN_MONUMENT)) update(player, TaskDefinitions.Route.MAIN, 4, "ocean_monument", 1, true);
    if (profile.main.task.activeId == 5 && near(player, StructureType.END_CITY)) update(player, TaskDefinitions.Route.MAIN, 5, "end_city", 1, true);
    if (profile.main.task.activeId == 9 && near(player, Structure.ANCIENT_CITY)) update(player, TaskDefinitions.Route.MAIN, 9, "ancient_city", 1, true);
  }

  private boolean near(Player player, StructureType type) {
    var found = player.getWorld().locateNearestStructure(player.getLocation(), type, 32, false);
    return found != null && found.getWorld().equals(player.getWorld()) && found.distanceSquared(player.getLocation()) <= 64 * 64;
  }

  private boolean near(Player player, Structure structure) {
    var found = player.getWorld().locateNearestStructure(player.getLocation(), structure, 32, false);
    return found != null && found.getLocation().getWorld().equals(player.getWorld()) && found.getLocation().distanceSquared(player.getLocation()) <= 64 * 64;
  }

  @EventHandler(ignoreCancelled = true, priority = EventPriority.MONITOR)
  public void interact(PlayerInteractEvent event) {
    if (event.getAction() != Action.RIGHT_CLICK_BLOCK || event.getItem() == null || event.getClickedBlock() == null) return;
    Material item = event.getItem().getType();
    if (item == Material.TRIAL_KEY && event.getClickedBlock().getType() == Material.VAULT) {
      update(event.getPlayer(), TaskDefinitions.Route.MAIN, 7, "trial_key", 1, true);
    }
    if (item == Material.END_CRYSTAL && (event.getClickedBlock().getType() == Material.OBSIDIAN || event.getClickedBlock().getType() == Material.BEDROCK)) {
      update(event.getPlayer(), TaskDefinitions.Route.MAIN, 10, "end_crystals", 1, false);
    }
  }

  private void update(Player player, TaskDefinitions.Route route, int taskId, String key, int amount, boolean critical) {
    PlayerProfile profile = profiles.get(player.getUniqueId());
    if (profile == null || !plugin.isEnabledWorld(player.getWorld())) return;
    if (route == TaskDefinitions.Route.MAIN && profile.child.enabled) return;
    if ((route == TaskDefinitions.Route.CHILD || route == TaskDefinitions.Route.BOSS) && !profile.child.enabled) return;
    PlayerProfile.Task task = task(profile, route);
    if (task.activeId != taskId) return;
    TaskDefinitions.Definition definition = TaskDefinitions.get(route, taskId);
    if (definition == null) return;
    TaskDefinitions.Goal goal = definition.goals().get(key);
    if (goal == null) return;
    set(task, key, task.progress.getOrDefault(key, 0) + amount, goal.target());
    profile.touch(player.getName());
    if (route == TaskDefinitions.Route.BOSS && task.progress.getOrDefault(key, 0) >= goal.target()) {
      String name = definition.name();
      complete(player, profile, route, taskId);
      player.sendMessage(Component.text(name + "完成，已永久获得 Boss 印记。", NamedTextColor.LIGHT_PURPLE));
      profiles.save(profile);
      return;
    }
    if (critical) profiles.save(profile);
  }

  private void set(PlayerProfile.Task task, String key, int value, int max) {
    task.progress.put(key, Math.max(0, Math.min(max, value)));
  }

  private int expectedStage(PlayerProfile profile, TaskDefinitions.Route route) {
    return switch (route) {
      case MAIN -> profile.main.stage;
      case CHILD -> profile.child.stage;
      case BOSS -> profile.child.bossStage;
      case ASCENSION -> 1;
    };
  }

  private PlayerProfile.Task task(PlayerProfile profile, TaskDefinitions.Route route) {
    return switch (route) {
      case MAIN -> profile.main.task;
      case CHILD -> profile.child.task;
      case BOSS, ASCENSION -> profile.child.bossTask;
    };
  }

  private String routeName(TaskDefinitions.Route route) {
    return switch (route) {
      case MAIN -> "main";
      case CHILD -> "child";
      case BOSS -> "boss";
      case ASCENSION -> "ascension";
    };
  }

  private String itemKind(TaskDefinitions.Route route) {
    return switch (route) {
      case MAIN -> "main_quest";
      case CHILD -> "child_quest";
      case BOSS -> "child_boss_quest";
      case ASCENSION -> "child_ascension_core";
    };
  }

  private int countLogs(Player player) {
    int total = 0;
    for (ItemStack item : player.getInventory().getContents()) if (item != null && item.getType().name().endsWith("_LOG")) total += item.getAmount();
    return total;
  }

  private void give(Player player, ItemStack... stacks) {
    for (ItemStack stack : stacks) InventoryUtil.giveOrDrop(player, stack);
  }

  private String completionSummary(TaskDefinitions.Route route, int id) {
    if (route != TaskDefinitions.Route.MAIN) return id == 6 ? "Boss 番外已开放。" : "下一章已解锁。";
    return switch (id) {
      case 1 -> "获得行旅补给，并解锁 5 级装备。";
      case 2 -> "获得采掘补给，并解锁 10 级装备。";
      case 3 -> "获得黑曜石与 20 分钟抗火补给。";
      case 4 -> "获得潮汐补给与 20 分钟水下呼吸。";
      case 5 -> "获得末影补给、缓降，并解锁 20 级装备。";
      case 6 -> "获得守卫补给，并解锁 32 级装备。";
      case 7 -> "获得试炼补给。";
      case 8 -> "获得终战补给，并解锁 64 级装备。";
      case 9 -> "获得幽匿补给。";
      case 10 -> "255 级终焉主宰装备现已永久解锁。";
      default -> "进度已保存。";
    };
  }

  private String twoDigits(int value) { return String.format("%02d", value); }
}
