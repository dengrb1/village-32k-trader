package cn.villagetrader.shop;

import cn.villagetrader.VillageTraderPlugin;
import cn.villagetrader.item.ItemService;
import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.storage.ProfileManager;
import cn.villagetrader.storage.ServerStateManager;
import cn.villagetrader.task.TaskDefinitions;
import cn.villagetrader.task.TaskService;
import cn.villagetrader.util.InventoryUtil;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Bukkit;
import org.bukkit.Material;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.inventory.InventoryClickEvent;
import org.bukkit.event.inventory.InventoryDragEvent;
import org.bukkit.inventory.Inventory;
import org.bukkit.inventory.InventoryHolder;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.ItemMeta;

public final class ShopService implements Listener {
  private final VillageTraderPlugin plugin;
  private final ProfileManager profiles;
  private final ServerStateManager serverState;
  private final ItemService items;
  private final TaskService tasks;

  public ShopService(VillageTraderPlugin plugin, ProfileManager profiles, ServerStateManager serverState, ItemService items, TaskService tasks) {
    this.plugin = plugin; this.profiles = profiles; this.serverState = serverState; this.items = items; this.tasks = tasks;
  }

  public void open(Player player) {
    if (!plugin.isEnabledWorld(player.getWorld())) { error(player, "此世界未启用 VillageTrader。"); return; }
    PlayerProfile p = profiles.get(player.getUniqueId());
    if (p == null || p.writeBlocked) { error(player, "档案尚未加载或已因损坏锁定。"); return; }
    Menu menu = new Menu(Component.text("村庄成长商店"));
    menu.button(10, icon(Material.DIAMOND, "资源与消耗品", "按当前路线和阶段显示"), this::openGoods);
    menu.button(12, icon(Material.PAPER, "当前任务", "购买、补领、提交与目标详情"), this::openTasks);
    menu.button(14, icon(Material.TOTEM_OF_UNDYING, "辅助用品", "购买、选择与免费补领"), this::openAuxiliaries);
    menu.button(16, icon(Material.NETHERITE_CHESTPLATE, "装备与回溯", "查看已解锁装备阶级"), this::openEquipment);
    menu.button(29, icon(Material.BOOK, "教程", tutorial(p)), ignored -> openTutorial(player));
    menu.button(31, icon(Material.COMPARATOR, "设置与路线", p.child.enabled ? "当前：儿童守护线" : "当前：主线"), this::openSettings);
    menu.button(33, icon(Material.TRIPWIRE_HOOK, "便携钥匙", p.portableKeyAuthorized ? "已授权" : "未授权（管理员发放）"), ignored -> {});
    player.openInventory(menu.inventory);
  }

  private void openGoods(Player player) {
    PlayerProfile p = profiles.get(player.getUniqueId());
    Menu menu = new Menu(Component.text(p.child.enabled ? "儿童普通商品" : "主线资源与消耗品"));
    if (p.child.enabled) {
      Goods[] goods = {new Goods(Material.COBBLESTONE, 64, 1), new Goods(Material.OAK_LOG, 32, 1), new Goods(Material.IRON_INGOT, 16, 2), new Goods(Material.BREAD, 16, 2), new Goods(Material.TORCH, 64, 3), new Goods(Material.SHIELD, 1, 4), new Goods(Material.EMERALD, 8, 5), new Goods(Material.GOLDEN_APPLE, 2, 6)};
      int slot = 10;
      for (Goods good : goods) { int s = slot++; menu.button(s, icon(good.material, good.material.translationKey(), "获得 ×" + good.amount + "，解锁章 " + good.stage), pl -> purchaseChildGood(pl, good)); }
    } else {
      Goods[] goods = {new Goods(Material.DIAMOND, 64, 2), new Goods(Material.EMERALD, 64, 2), new Goods(Material.GOLDEN_APPLE, 8, 2), new Goods(Material.DIAMOND_BLOCK, 16, 3), new Goods(Material.EMERALD_BLOCK, 16, 3), new Goods(Material.NETHERITE_SCRAP, 16, 3), new Goods(Material.NETHERITE_INGOT, 8, 4), new Goods(Material.ENCHANTED_GOLDEN_APPLE, 2, 4), new Goods(Material.TOTEM_OF_UNDYING, 1, 5), new Goods(Material.NETHERITE_BLOCK, 4, 6)};
      int slot = 10;
      for (Goods good : goods) { int s = slot++; menu.button(s, icon(good.material, good.material.translationKey(), "获得 ×" + good.amount + "，解锁阶段 " + good.stage), pl -> purchaseMainGood(pl, good)); }
    }
    back(menu, 49);
    player.openInventory(menu.inventory);
  }

  private void openTasks(Player player) {
    PlayerProfile p = profiles.get(player.getUniqueId());
    TaskDefinitions.Route route = currentRoute(p);
    int stage = currentStage(p, route);
    Menu menu = new Menu(Component.text("当前任务与提交"));
    TaskDefinitions.Definition definition = TaskDefinitions.get(route, stage);
    if (p.child.enabled && p.child.stage >= 7 && p.child.bossStage >= 4) {
      menu.button(13, icon(Material.NETHER_STAR, p.child.ascended ? "守护升格已完成" : "守护升格核心", p.child.ascended ? "128级强化守护装备已解锁" : "需要龙、凋灵、幽匿三个印记"), ignored -> {});
      if (!p.child.ascended) {
        menu.button(29, icon(Material.DIAMOND, "兑换升格核心", "钻石×16 + 下界合金锭×4"), this::buyAscension);
        menu.button(33, icon(Material.LIME_DYE, "提交升格核心", "校验三个印记、所有权和本人绑定核心"), this::submitAscension);
      }
      back(menu, 49); player.openInventory(menu.inventory); return;
    }
    String name = definition == null ? "当前路线已完成" : definition.name();
    menu.button(13, icon(Material.WRITABLE_BOOK, name, definition == null ? "无后续普通任务" : goals(definition)), ignored -> {});
    if (definition != null) {
      menu.button(29, icon(Material.EMERALD, route == TaskDefinitions.Route.BOSS ? "购买 Boss 挑战书" : "购买并激活任务牌", costText(taskCost(route, stage))), pl -> purchaseTask(pl, route, stage));
      menu.button(31, icon(Material.PAPER, "免费补领一次", "仅当前任务牌丢失且尚未补领时可用"), pl -> reissue(pl, route, stage));
      menu.button(33, icon(Material.LIME_DYE, route == TaskDefinitions.Route.BOSS ? "提交挑战书并开始挑战" : "提交当前任务", route == TaskDefinitions.Route.BOSS ? "挑战书先消耗，之后击杀才记录印记" : "会校验所有目标和本人绑定任务牌"), pl -> { if (route == TaskDefinitions.Route.BOSS) activateBossChallenge(pl, stage); else tasks.submit(pl, route); openTasks(pl); });
    }
    back(menu, 49);
    player.openInventory(menu.inventory);
  }

  private void openAuxiliaries(Player player) {
    PlayerProfile p = profiles.get(player.getUniqueId());
    Menu menu = new Menu(Component.text("可选辅助用品"));
    String[] mainNames = {"矿工补给包", "下界护符", "末地护符", "袭击守护符", "凋灵净化符", "幽匿护符"};
    String[] childNames = {"学徒护符", "红石工具包", "归途罗盘", "金苹果护符", "商人徽章", "龙战护符", "凋灵护符", "净化乳剂", "幽匿软靴"};
    int max = p.child.enabled ? 9 : 6;
    for (int id = 1; id <= max; id++) {
      int itemId = id;
      String name = p.child.enabled ? childNames[id - 1] : mainNames[id - 1];
      boolean owned = p.child.enabled ? p.childAuxiliaries.contains(id) : p.mainAuxiliaries.contains(id);
      menu.button(9 + id, icon(Material.PAPER, name, owned ? "已登记：点击选择/缺失时补领" : "点击购买并登记"), pl -> auxiliary(pl, p.child.enabled, itemId, name));
    }
    back(menu, 49);
    player.openInventory(menu.inventory);
  }

  private void openEquipment(Player player) {
    PlayerProfile p = profiles.get(player.getUniqueId());
    Menu menu = new Menu(Component.text("装备与旧装备回溯"));
    int[] tiers = {1, 5, 10, 20, 32, 64, 128, 255};
    int slot = 10;
    for (int tier : tiers) {
      boolean unlocked = tier == 1 || p.equipmentTiers.contains(tier) || (tier == p.main.equipmentTier);
      menu.button(slot++, icon(unlocked ? Material.NETHERITE_CHESTPLATE : Material.BARRIER, tier + "级装备", unlocked ? "点击领取本人绑定套装" : "尚未解锁"), pl -> { if (unlocked) plugin.effects().giveEquipment(pl, tier); });
    }
    back(menu, 49); player.openInventory(menu.inventory);
  }

  private void openSettings(Player player) {
    PlayerProfile p = profiles.get(player.getUniqueId());
    Menu menu = new Menu(Component.text("设置与路线"));
    menu.button(12, icon(Material.DIAMOND_SWORD, "切换到主线", "保留儿童线进度并暂停计数"), pl -> { p.child.enabled = false; profiles.save(p); open(pl); });
    menu.button(14, icon(Material.SHIELD, "切换到儿童守护线", "保留主线进度并暂停主线计数"), pl -> { p.child.enabled = true; profiles.save(p); open(pl); });
    menu.button(31, icon(Material.NETHERITE_SWORD, "困难终局", p.main.stage >= 7 ? "点击切换困难标记" : "完成深暗挑战后开放"), pl -> { if (p.main.stage >= 7) { p.main.hardMode = !p.main.hardMode; profiles.save(p); openSettings(pl); } });
    back(menu, 49); player.openInventory(menu.inventory);
  }

  private void openTutorial(Player player) {
    Menu menu = new Menu(Component.text("VillageTrader 教程"));
    menu.button(11, icon(Material.PAPER, "任务", "先购买任务牌，激活后事件才计数；完成后携带本人任务牌提交。"), ignored -> {});
    menu.button(13, icon(Material.CHEST, "交易", "点击前会完整校验材料、阶段、任务与所有权，再一次性扣除。"), ignored -> {});
    menu.button(15, icon(Material.TRIPWIRE_HOOK, "钥匙", "只认档案授权和物品内领取者 UUID，转交无效。"), ignored -> {});
    back(menu, 49); player.openInventory(menu.inventory);
  }

  private void purchaseTask(Player player, TaskDefinitions.Route route, int stage) {
    PlayerProfile p = profiles.get(player.getUniqueId());
    PlayerProfile.Task task = profileTask(p, route);
    if (task.activeId != 0 || task.ownedCardId != 0) { error(player, "已有任务处于激活或持有状态。"); return; }
    Map<Material, Integer> cost = new LinkedHashMap<>(taskCost(route, stage));
    if (route == TaskDefinitions.Route.MAIN) merge(cost, surcharge());
    if (!payTaskCost(player, route, stage, cost)) { error(player, "材料不足：" + costText(cost)); return; }
    if (route == TaskDefinitions.Route.BOSS) {
      task.ownedCardId = stage; task.activeId = 0; task.replacementClaimed = false;
      player.getInventory().addItem(items.taskCard(player, "boss", stage)); profiles.save(p);
      player.sendActionBar(Component.text("挑战书已购买；提交并消耗后才开始记录 Boss 击杀。", NamedTextColor.GREEN));
    } else {
      tasks.activate(player, route, stage);
      player.sendActionBar(Component.text("任务牌已购买并激活。", NamedTextColor.GREEN));
    }
    openTasks(player);
  }

  private void reissue(Player player, TaskDefinitions.Route route, int stage) {
    PlayerProfile p = profiles.get(player.getUniqueId()); PlayerProfile.Task task = profileTask(p, route);
    if (task.ownedCardId != stage || task.replacementClaimed || items.has(player, itemKind(route), stage)) { error(player, "不满足补领条件，或任务牌仍在背包中。"); return; }
    player.getInventory().addItem(items.taskCard(player, routeName(route), stage)); task.replacementClaimed = true; profiles.save(p);
    player.sendActionBar(Component.text("已免费补领当前任务牌。", NamedTextColor.AQUA));
  }

  private void activateBossChallenge(Player player, int stage) {
    PlayerProfile p=profiles.get(player.getUniqueId());PlayerProfile.Task task=p.child.bossTask;
    if(task.activeId==stage){error(player,"当前 Boss 挑战已经激活，击杀目标即可获得印记。");return;}
    if(task.ownedCardId!=stage||!items.removeOne(player,"child_boss_quest",stage)){error(player,"缺少本人绑定的当前 Boss 挑战书。");return;}
    task.activeId=stage;task.ownedCardId=0;task.progress.clear();profiles.save(p);success(player,"挑战书已消耗，Boss 挑战正式激活。");
  }

  private void buyAscension(Player player) {
    PlayerProfile p=profiles.get(player.getUniqueId());if(p.child.ascended||p.child.ascensionKeyOwned){error(player,"升格核心已登记或升格已完成。");return;}
    if(!p.child.bossMarks.containsAll(List.of("dragon","wither","warden"))){error(player,"尚未集齐三个 Boss 印记。");return;}
    Map<Material,Integer> cost=InventoryUtil.cost(Material.DIAMOND,16,Material.NETHERITE_INGOT,4);if(!InventoryUtil.pay(player,cost)){error(player,"材料不足："+costText(cost));return;}
    p.child.ascensionKeyOwned=true;player.getInventory().addItem(items.taskCard(player,"ascension",1));profiles.save(p);success(player,"已兑换本人绑定的守护升格核心。");openTasks(player);
  }

  private void submitAscension(Player player) {
    PlayerProfile p=profiles.get(player.getUniqueId());if(!p.child.ascensionKeyOwned||!p.child.bossMarks.containsAll(List.of("dragon","wither","warden"))){error(player,"缺少升格核心所有权或三个 Boss 印记。");return;}
    if(!items.removeOne(player,"child_ascension_core",1)){error(player,"背包中没有本人绑定的守护升格核心。");return;}
    p.child.ascensionKeyOwned=false;p.child.ascended=true;p.equipmentTiers.add(128);profiles.save(p);player.sendMessage(Component.text("守护升格完成！128级强化守护装备已永久解锁。",NamedTextColor.LIGHT_PURPLE));openTasks(player);
  }

  private void purchaseMainGood(Player player, Goods good) {
    PlayerProfile p = profiles.get(player.getUniqueId()); if (p.main.stage < good.stage) { error(player, "尚未解锁此商品。"); return; }
    Map<Material, Integer> price = goodsPrice(); if (!InventoryUtil.pay(player, price)) { error(player, "支付物不足：" + costText(price)); return; }
    player.getInventory().addItem(new ItemStack(good.material, good.amount)); success(player, "兑换成功 ×" + good.amount);
  }

  private void purchaseChildGood(Player player, Goods good) {
    PlayerProfile p = profiles.get(player.getUniqueId()); if (p.child.stage < good.stage) { error(player, "尚未解锁此商品。"); return; }
    int dirt = p.selectedChildAuxiliary == 5 && p.childAuxiliaries.contains(5) && items.has(player, "child_aux", 5) ? 1 : 4;
    if (!InventoryUtil.pay(player, InventoryUtil.cost(Material.DIRT, dirt))) { error(player, "泥土不足，需要 " + dirt + " 个。"); return; }
    player.getInventory().addItem(new ItemStack(good.material, good.amount)); tasks.recordChildPurchase(player); success(player, "兑换成功 ×" + good.amount);
  }

  private void auxiliary(Player player, boolean child, int id, String name) {
    PlayerProfile p = profiles.get(player.getUniqueId()); boolean owned = child ? p.childAuxiliaries.contains(id) : p.mainAuxiliaries.contains(id); String kind = child ? "child_aux" : "main_aid";
    if (owned) {
      if (!items.has(player, kind, id)) player.getInventory().addItem(items.auxiliary(player, child, id, name));
      if (child) p.selectedChildAuxiliary = id; else p.selectedMainAuxiliary = id;
      profiles.save(p); success(player, "已选择 " + name); return;
    }
    Map<Material, Integer> cost = child ? childAuxCost(id) : mainAuxCost(id);
    if (!child) { cost = new LinkedHashMap<>(cost); merge(cost, surcharge()); }
    if (!payAuxCost(player, child, id, cost)) { error(player, "材料不足：" + costText(cost)); return; }
    if (child) { p.childAuxiliaries.add(id); p.selectedChildAuxiliary = id; } else { p.mainAuxiliaries.add(id); p.selectedMainAuxiliary = id; }
    player.getInventory().addItem(items.auxiliary(player, child, id, name)); profiles.save(p); success(player, "已购买并登记 " + name);
  }

  private Map<Material, Integer> goodsPrice() { return switch (serverState.state().penaltyLevel) { case 1 -> InventoryUtil.cost(Material.DIRT, 16); case 2 -> InventoryUtil.cost(Material.EMERALD, 16); case 3 -> InventoryUtil.cost(Material.NETHERITE_INGOT, 4); default -> InventoryUtil.cost(Material.DIRT, 1); }; }
  private Map<Material, Integer> surcharge() { return switch (serverState.state().penaltyLevel) { case 1 -> InventoryUtil.cost(Material.DIRT, 16); case 2 -> InventoryUtil.cost(Material.EMERALD, 16); case 3 -> InventoryUtil.cost(Material.NETHERITE_INGOT, 4); default -> Map.of(); }; }
  private Map<Material, Integer> taskCost(TaskDefinitions.Route route, int id) {
    if (route == TaskDefinitions.Route.MAIN) return switch (id) { case 1 -> InventoryUtil.cost(Material.IRON_INGOT,16,Material.COAL,8); case 2 -> InventoryUtil.cost(Material.OBSIDIAN,8,Material.FLINT_AND_STEEL,1,Material.GOLD_INGOT,4); case 3 -> InventoryUtil.cost(Material.ENDER_PEARL,12,Material.BLAZE_POWDER,12); case 4 -> InventoryUtil.cost(Material.EMERALD,16,Material.OMINOUS_BOTTLE,1); case 5 -> InventoryUtil.cost(Material.SOUL_SAND,4,Material.OBSIDIAN,8,Material.ENCHANTED_GOLDEN_APPLE,1); default -> InventoryUtil.cost(Material.ECHO_SHARD,8,Material.SCULK_CATALYST,1,Material.TOTEM_OF_UNDYING,1); };
    if (route == TaskDefinitions.Route.BOSS) return switch (id) { case 1 -> InventoryUtil.cost(Material.DIAMOND,8,Material.GOLDEN_APPLE,2); case 2 -> InventoryUtil.cost(Material.EMERALD_BLOCK,4,Material.GOLDEN_APPLE,2,Material.MILK_BUCKET,1); default -> InventoryUtil.cost(Material.ECHO_SHARD,8,Material.WHITE_WOOL,16,Material.TOTEM_OF_UNDYING,1); };
    return switch (id) { case 1 -> InventoryUtil.cost(Material.OAK_LOG,4); case 2 -> InventoryUtil.cost(Material.IRON_INGOT,3,Material.COAL,8); case 3 -> InventoryUtil.cost(Material.COAL,8,Material.WHEAT,8); case 4 -> InventoryUtil.cost(Material.ROTTEN_FLESH,3,Material.BONE,3); case 5 -> InventoryUtil.cost(Material.DIAMOND,1,Material.EMERALD,4); default -> InventoryUtil.cost(Material.DIAMOND,1,Material.GOLD_INGOT,8,Material.GOLDEN_APPLE,1); };
  }
  private boolean payTaskCost(Player player,TaskDefinitions.Route route,int stage,Map<Material,Integer> cost){
    if(route==TaskDefinitions.Route.CHILD&&stage==1)return InventoryUtil.payMatching(player,m->m.name().endsWith("_LOG"),4);
    if(route==TaskDefinitions.Route.BOSS&&stage==3){Map<Material,Integer> withoutWool=new LinkedHashMap<>(cost);withoutWool.remove(Material.WHITE_WOOL);if(!InventoryUtil.has(player,withoutWool)||InventoryUtil.countMatching(player,m->m.name().endsWith("_WOOL"))<16)return false;InventoryUtil.pay(player,withoutWool);return InventoryUtil.payMatching(player,m->m.name().endsWith("_WOOL"),16);}
    return InventoryUtil.pay(player,cost);
  }
  private boolean payAuxCost(Player player,boolean child,int id,Map<Material,Integer> cost){if(child&&id==9){Map<Material,Integer> withoutWool=new LinkedHashMap<>(cost);withoutWool.remove(Material.WHITE_WOOL);if(!InventoryUtil.has(player,withoutWool)||InventoryUtil.countMatching(player,m->m.name().endsWith("_WOOL"))<8)return false;InventoryUtil.pay(player,withoutWool);return InventoryUtil.payMatching(player,m->m.name().endsWith("_WOOL"),8);}return InventoryUtil.pay(player,cost);}
  private Map<Material,Integer> mainAuxCost(int id) { return switch(id){case 1->InventoryUtil.cost(Material.EMERALD,8);case 2->InventoryUtil.cost(Material.DIAMOND,4);case 3->InventoryUtil.cost(Material.GOLDEN_APPLE,1);case 4->InventoryUtil.cost(Material.EMERALD_BLOCK,1);case 5->InventoryUtil.cost(Material.DIAMOND_BLOCK,1);default->InventoryUtil.cost(Material.ECHO_SHARD,4);}; }
  private Map<Material,Integer> childAuxCost(int id) { return switch(id){case 1->InventoryUtil.cost(Material.LEATHER,2,Material.IRON_INGOT,2);case 2->InventoryUtil.cost(Material.COPPER_INGOT,4,Material.REDSTONE,2);case 3->InventoryUtil.cost(Material.COMPASS,1,Material.BREAD,4);case 4->InventoryUtil.cost(Material.GOLD_INGOT,4,Material.GOLDEN_APPLE,1);case 5->InventoryUtil.cost(Material.EMERALD,8);case 6->InventoryUtil.cost(Material.DIAMOND,1,Material.TOTEM_OF_UNDYING,1);case 7->InventoryUtil.cost(Material.DIAMOND,4,Material.GOLDEN_APPLE,1);case 8->InventoryUtil.cost(Material.EMERALD_BLOCK,2,Material.MILK_BUCKET,1);default->InventoryUtil.cost(Material.ECHO_SHARD,4,Material.WHITE_WOOL,8);}; }

  @EventHandler public void click(InventoryClickEvent event) { if (!(event.getInventory().getHolder(false) instanceof Menu menu)) return; event.setCancelled(true); if (!(event.getWhoClicked() instanceof Player player) || event.getClickedInventory() != event.getView().getTopInventory()) return; Consumer<Player> action = menu.actions.get(event.getSlot()); if (action != null) action.accept(player); }
  @EventHandler public void drag(InventoryDragEvent event) { if (event.getInventory().getHolder(false) instanceof Menu) event.setCancelled(true); }

  private void back(Menu menu, int slot) { menu.button(slot, icon(Material.ARROW, "返回", "回到商店首页"), this::open); }
  private ItemStack icon(Material material, String name, String lore) { ItemStack item = new ItemStack(material); ItemMeta meta = item.getItemMeta(); meta.displayName(Component.text(name, NamedTextColor.GOLD)); meta.lore(List.of(Component.text(lore, NamedTextColor.GRAY))); item.setItemMeta(meta); return item; }
  private String tutorial(PlayerProfile p) { return p.child.enabled ? "儿童线：完成六章后开放 Boss 番外和升格" : "主线：任务牌激活后才开始计数"; }
  private String goals(TaskDefinitions.Definition d) { StringBuilder text = new StringBuilder(); for (var g : d.goals().values()) { if (!text.isEmpty()) text.append("；"); text.append(g.label()).append("×").append(g.target()); } return text.toString(); }
  private String costText(Map<Material,Integer> cost) { if (cost.isEmpty()) return "免费"; StringBuilder text = new StringBuilder(); cost.forEach((m,a)->{if(!text.isEmpty())text.append(" + ");text.append(m.translationKey()).append("×").append(a);}); return text.toString(); }
  private void merge(Map<Material,Integer> target, Map<Material,Integer> extra) { extra.forEach((m,a)->target.merge(m,a,Integer::sum)); }
  private void error(Player p,String s){p.sendActionBar(Component.text(s,NamedTextColor.RED));}
  private void success(Player p,String s){p.sendActionBar(Component.text(s,NamedTextColor.GREEN));}
  private TaskDefinitions.Route currentRoute(PlayerProfile p) { if (!p.child.enabled) return TaskDefinitions.Route.MAIN; if (p.child.stage >= 7 && p.child.bossStage <= 3) return TaskDefinitions.Route.BOSS; return TaskDefinitions.Route.CHILD; }
  private int currentStage(PlayerProfile p,TaskDefinitions.Route r){return switch(r){case MAIN->p.main.stage;case CHILD->p.child.stage;case BOSS->p.child.bossStage;case ASCENSION->1;};}
  private PlayerProfile.Task profileTask(PlayerProfile p,TaskDefinitions.Route r){return switch(r){case MAIN->p.main.task;case CHILD->p.child.task;case BOSS,ASCENSION->p.child.bossTask;};}
  private String routeName(TaskDefinitions.Route r){return switch(r){case MAIN->"main";case CHILD->"child";case BOSS->"boss";case ASCENSION->"ascension";};}
  private String itemKind(TaskDefinitions.Route r){return switch(r){case MAIN->"main_quest";case CHILD->"child_quest";case BOSS->"child_boss_quest";case ASCENSION->"child_ascension_core";};}

  private record Goods(Material material,int amount,int stage){}
  private final class Menu implements InventoryHolder {
    private final Inventory inventory; private final Map<Integer,Consumer<Player>> actions=new HashMap<>();
    private Menu(Component title){inventory=Bukkit.createInventory(this,54,title);}
    private void button(int slot,ItemStack item,Consumer<Player> action){inventory.setItem(slot,item);actions.put(slot,action);}
    @Override public Inventory getInventory(){return inventory;}
  }
}
