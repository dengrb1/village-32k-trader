package cn.villagetrader.achievement;

import java.util.ArrayList;
import java.util.Collections;
import java.util.EnumMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Immutable catalogue shared by awards, the archive menu and profile checks. */
public final class AchievementDefinitions {
  public enum Category {
    STORY("story", "剧情", 10),
    EXPLORE("explore", "探索", 8),
    COMBAT("combat", "战斗", 8),
    TRADE("trade", "商会", 7),
    GUARDIAN("guardian", "守护", 7);

    private final String key;
    private final String displayName;
    private final int target;

    Category(String key, String displayName, int target) {
      this.key = key;
      this.displayName = displayName;
      this.target = target;
    }

    public String key() { return key; }
    public String displayName() { return displayName; }
    public int target() { return target; }
  }

  public record Definition(String id, Category category, String name, String description) {}

  private static final Map<String, Definition> BY_ID = new LinkedHashMap<>();
  private static final Map<Category, List<Definition>> BY_CATEGORY = new EnumMap<>(Category.class);

  static {
    for (Category category : Category.values()) BY_CATEGORY.put(category, new ArrayList<>());

    story(1, "安居第一夜", "完成定居启程");
    story(2, "矿脉初醒", "完成矿脉勘探");
    story(3, "炽热远征", "完成下界远征");
    story(4, "潮汐航线", "完成沧海巡航");
    story(5, "末地远征", "完成末地远征");
    story(6, "守卫家园", "完成村庄守卫");
    story(7, "试炼破阵", "完成试炼密室");
    story(8, "凋灵终结", "完成凋灵攻坚");
    story(9, "深暗净化", "完成深暗净化");
    story(10, "龙魂再临", "完成十章主线");

    explore(1, "矿脉下探", "踏入深层采掘旅程");
    explore(2, "下界门户", "越过炽热边界");
    explore(3, "深海古迹", "巡航海底遗迹");
    explore(4, "虚空边境", "抵达末地");
    explore(5, "试炼密室", "通过试炼密室");
    explore(6, "灵魂祭坛", "在下界完成凋灵准备");
    explore(7, "幽匿深渊", "净化深暗之域");
    explore(8, "重临末地", "唤醒末影龙");

    combat(1, "百战初试", "完成矿脉战斗目标");
    combat(2, "烈焰克星", "击败烈焰人军团");
    combat(3, "海底巨兽", "击败远古守卫者");
    combat(4, "终界巨龙", "首次击败末影龙");
    combat(5, "袭击粉碎", "赢得一次袭击");
    combat(6, "旋风终结", "击败试炼旋风人");
    combat(7, "凋灵猎手", "击败凋灵");
    combat(8, "深暗猎手", "击败监守者");

    trade(1, "第一份契约", "激活第一张主线任务牌");
    trade(2, "钻石签章", "兑换 5 级装备");
    trade(3, "下界签章", "兑换 10 级装备");
    trade(4, "传说签章", "兑换 20 级装备");
    trade(5, "神话签章", "兑换 32 级装备");
    trade(6, "终焉签章", "兑换 64 级装备");
    trade(7, "主宰签章", "兑换 255 级装备");

    guardian(1, "初次守护", "完成儿童第一章");
    guardian(2, "安全过夜", "完成儿童安全过夜章节");
    guardian(3, "守护毕业", "完成儿童守护线");
    guardian(4, "龙之印", "完成儿童末影龙番外");
    guardian(5, "凋灵之印", "完成儿童凋灵番外");
    guardian(6, "幽匿之印", "完成儿童监守者番外");
    guardian(7, "守护升格", "提交守护升格核心");
  }

  private AchievementDefinitions() {}

  public static Definition get(String id) { return BY_ID.get(id); }
  public static List<Definition> all(Category category) { return Collections.unmodifiableList(BY_CATEGORY.get(category)); }
  public static List<Definition> all() { return List.copyOf(BY_ID.values()); }
  public static int total() { return BY_ID.size(); }

  private static void story(int number, String name, String description) { add(Category.STORY, number, name, description); }
  private static void explore(int number, String name, String description) { add(Category.EXPLORE, number, name, description); }
  private static void combat(int number, String name, String description) { add(Category.COMBAT, number, name, description); }
  private static void trade(int number, String name, String description) { add(Category.TRADE, number, name, description); }
  private static void guardian(int number, String name, String description) { add(Category.GUARDIAN, number, name, description); }

  private static void add(Category category, int number, String name, String description) {
    String id = category.key() + "_" + String.format("%02d", number);
    Definition definition = new Definition(id, category, name, description);
    BY_ID.put(id, definition);
    BY_CATEGORY.get(category).add(definition);
  }
}
