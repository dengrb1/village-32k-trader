package cn.villagetrader.item;

import cn.villagetrader.VillageTraderPlugin;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Locale;
import java.util.UUID;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Material;
import org.bukkit.NamespacedKey;
import org.bukkit.entity.Player;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.ItemMeta;
import org.bukkit.persistence.PersistentDataContainer;
import org.bukkit.persistence.PersistentDataType;

public final class ItemService {
  private final NamespacedKey kindKey;
  private final NamespacedKey idKey;
  private final NamespacedKey ownerKey;

  public ItemService(VillageTraderPlugin plugin) {
    kindKey = new NamespacedKey(plugin, "kind");
    idKey = new NamespacedKey(plugin, "id");
    ownerKey = new NamespacedKey(plugin, "owner");
  }

  public ItemStack create(Material material, String name, String kind, int id, UUID owner, List<Component> lore) {
    ItemStack item = new ItemStack(material);
    ItemMeta meta = item.getItemMeta();
    meta.displayName(Component.text(name, NamedTextColor.GOLD));
    meta.lore(lore);
    meta.setEnchantmentGlintOverride(true);
    PersistentDataContainer pdc = meta.getPersistentDataContainer();
    pdc.set(kindKey, PersistentDataType.STRING, kind);
    pdc.set(idKey, PersistentDataType.INTEGER, id);
    pdc.set(ownerKey, PersistentDataType.STRING, owner.toString());
    item.setItemMeta(meta);
    return item;
  }

  public ItemStack taskCard(Player player, String route, int id) {
    String label = switch (route) {
      case "main" -> "主线任务牌 · 第" + id + "阶段";
      case "child" -> "儿童守护任务牌 · 第" + id + "章";
      case "boss" -> "守护 Boss 挑战书 · 第" + id + "章";
      default -> "守护升格核心";
    };
    String kind = switch (route) {
      case "main" -> "main_quest";
      case "child" -> "child_quest";
      case "boss" -> "child_boss_quest";
      default -> "child_ascension_core";
    };
    return create(Material.PAPER, label, kind, id, player.getUniqueId(), List.of(
        Component.text("仅绑定领取者可用于提交", NamedTextColor.AQUA),
        Component.text("转交不会转移任务权限", NamedTextColor.GRAY)));
  }

  public ItemStack key(Player player) {
    return create(Material.TRIPWIRE_HOOK, "便携商店钥匙", "portable_key", 1, player.getUniqueId(), List.of(
        Component.text("右键打开你的个人成长商店", NamedTextColor.AQUA),
        Component.text("权限与原领取者 UUID 绑定", NamedTextColor.GRAY)));
  }

  public ItemStack auxiliary(Player player, boolean child, int id, String name) {
    return create(Material.PAPER, name, child ? "child_aux" : "main_aid", id, player.getUniqueId(), List.of(
        Component.text("购买后永久登记；携带并选中时生效", NamedTextColor.AQUA)));
  }

  public boolean matches(ItemStack item, String kind, int id, UUID owner) {
    if (item == null || item.getType().isAir() || !item.hasItemMeta()) return false;
    PersistentDataContainer pdc = item.getItemMeta().getPersistentDataContainer();
    return kind.equals(pdc.get(kindKey, PersistentDataType.STRING))
        && Integer.valueOf(id).equals(pdc.get(idKey, PersistentDataType.INTEGER))
        && owner.toString().equals(pdc.get(ownerKey, PersistentDataType.STRING));
  }

  public boolean has(Player player, String kind, int id) {
    for (ItemStack item : player.getInventory().getContents()) if (matches(item, kind, id, player.getUniqueId())) return true;
    return false;
  }

  public boolean removeOne(Player player, String kind, int id) {
    ItemStack[] contents = player.getInventory().getContents();
    for (int slot = 0; slot < contents.length; slot++) {
      ItemStack item = contents[slot];
      if (!matches(item, kind, id, player.getUniqueId())) continue;
      if (item.getAmount() <= 1) player.getInventory().setItem(slot, null);
      else item.setAmount(item.getAmount() - 1);
      return true;
    }
    return false;
  }

  public int convertLegacyItems(Player player) {
    int converted = 0;
    ItemStack[] contents = player.getInventory().getContents();
    for (int slot = 0; slot < contents.length; slot++) {
      ItemStack item = contents[slot];
      if (item == null || item.getType().isAir() || identity(item) != null) continue;
      LegacyIdentity legacy = readLegacyIdentity(item);
      if (legacy == null) continue;
      ItemMeta meta = item.getItemMeta();
      meta.getPersistentDataContainer().set(kindKey, PersistentDataType.STRING, legacy.kind());
      meta.getPersistentDataContainer().set(idKey, PersistentDataType.INTEGER, legacy.id());
      meta.getPersistentDataContainer().set(ownerKey, PersistentDataType.STRING, player.getUniqueId().toString());
      item.setItemMeta(meta);
      converted++;
    }
    return converted;
  }

  public LegacyIdentity identity(ItemStack item) {
    if (item == null || !item.hasItemMeta()) return null;
    var pdc = item.getItemMeta().getPersistentDataContainer();
    String kind = pdc.get(kindKey, PersistentDataType.STRING);
    Integer id = pdc.get(idKey, PersistentDataType.INTEGER);
    return kind == null || id == null ? null : new LegacyIdentity(kind, id);
  }

  private LegacyIdentity readLegacyIdentity(ItemStack item) {
    // Paper 各构建对 custom_data 的强类型包装有变动，反射只用于一次性兼容读取。
    String serialized = item.toString().toLowerCase(Locale.ROOT);
    try {
      Method serialize = item.getClass().getMethod("serialize");
      serialized += " " + serialize.invoke(item).toString().toLowerCase(Locale.ROOT);
    } catch (ReflectiveOperationException ignored) {}
    String[] kinds = {"main_quest", "child_quest", "child_boss_quest", "child_ascension_core", "main_aid", "child_aux", "portable_key", "main_equipment", "child_equipment"};
    for (String kind : kinds) {
      if (!serialized.contains(kind)) continue;
      for (int id = 1; id <= 255; id++) {
        if (serialized.matches("(?s).*id[=: ]+" + id + "(?:[}, ]).*")) return new LegacyIdentity(kind, id);
      }
      return new LegacyIdentity(kind, 1);
    }
    return null;
  }

  public record LegacyIdentity(String kind, int id) {}
}
