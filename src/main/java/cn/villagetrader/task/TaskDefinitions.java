package cn.villagetrader.task;

import java.util.LinkedHashMap;
import java.util.Map;

public final class TaskDefinitions {
  public enum Route { MAIN, CHILD, BOSS, ASCENSION }
  public record Goal(String key, String label, int target) {}
  public record Definition(Route route, int id, String name, LinkedHashMap<String, Goal> goals) {}
  private static final Map<String, Definition> TASKS = new LinkedHashMap<>();

  static {
    main(1, "定居启程", goal("crafting_table", "制作工作台", 1), goal("sleep", "在床上睡一晚", 1));
    main(2, "矿脉勘探", goal("diamonds", "亲自挖掘钻石矿", 8), goal("hostiles", "击杀敌对生物", 20));
    main(3, "下界远征", goal("nether", "进入下界", 1), goal("blazes", "击杀烈焰人", 10), goal("debris", "亲自挖掘远古残骸", 4));
    main(4, "沧海巡航", goal("elder_guardian", "击杀远古守卫者", 1), goal("conduit", "制作潮涌核心", 1));
    main(5, "末地远征", goal("end", "进入末地", 1), goal("dragon", "击杀末影龙", 1));
    main(6, "村庄守卫", goal("raid", "亲自赢得袭击", 1), goal("totem", "激活后亲自拾取图腾", 1));
    main(7, "试炼密室", goal("breezes", "击杀旋风人", 3), goal("trial_key", "激活后使用试炼钥匙", 1));
    main(8, "凋灵攻坚", goal("wither", "击杀凋灵", 1), goal("beacon", "制作信标", 1));
    main(9, "深暗净化", goal("warden", "击杀监守者", 1), goal("echo_shards", "激活后亲自拾取回响碎片", 8));
    main(10, "龙魂再临", goal("end_crystals", "激活后使用末地水晶", 4), goal("dragon", "再次击杀末影龙", 1));
    child(1, "木工启程", goal("logs", "持有4个原木", 1), goal("table", "工作台", 1));
    child(2, "小小矿工", goal("cobble", "挖掘圆石", 16), goal("iron", "取出铁锭", 3));
    child(3, "安全过夜", goal("torches", "放置火把", 8), goal("eat", "进食", 1), goal("sleep", "成功睡床", 1));
    child(4, "勇气训练", goal("shield", "副手装备盾牌", 1), goal("training_kills", "僵尸或骷髅", 3));
    child(5, "商人助手", goal("purchase", "购买儿童商品", 1), goal("diamond", "挖掘钻石矿", 1), goal("emeralds", "持有4个绿宝石", 1));
    child(6, "守护毕业", goal("merchant", "右键成长商人", 1));
    boss(1, "末影龙番外", goal("dragon", "末影龙", 1));
    boss(2, "凋灵番外", goal("wither", "凋灵", 1));
    boss(3, "监守者番外", goal("warden", "监守者", 1));
  }

  private TaskDefinitions() {}
  public static Definition get(Route route, int id) { return TASKS.get(route + ":" + id); }
  private static Goal goal(String key, String label, int target) { return new Goal(key, label, target); }
  private static void main(int id, String name, Goal... goals) { add(Route.MAIN, id, name, goals); }
  private static void child(int id, String name, Goal... goals) { add(Route.CHILD, id, name, goals); }
  private static void boss(int id, String name, Goal... goals) { add(Route.BOSS, id, name, goals); }
  private static void add(Route route, int id, String name, Goal... goals) {
    LinkedHashMap<String, Goal> map = new LinkedHashMap<>();
    for (Goal goal : goals) map.put(goal.key(), goal);
    TASKS.put(route + ":" + id, new Definition(route, id, name, map));
  }
}
