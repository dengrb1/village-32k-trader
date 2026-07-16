package cn.villagetrader.util;

import java.util.LinkedHashMap;
import java.util.Map;
import org.bukkit.Material;
import org.bukkit.entity.Player;
import org.bukkit.inventory.ItemStack;

public final class InventoryUtil {
  private InventoryUtil() {}

  public static boolean has(Player player, Map<Material, Integer> cost) {
    for (var entry : cost.entrySet()) {
      int count = 0;
      for (ItemStack item : player.getInventory().getContents()) {
        if (item != null && item.getType() == entry.getKey()) count += item.getAmount();
      }
      if (count < entry.getValue()) return false;
    }
    return true;
  }

  public static boolean pay(Player player, Map<Material, Integer> cost) {
    if (!has(player, cost)) return false;
    for (var entry : cost.entrySet()) remove(player, entry.getKey(), entry.getValue());
    return true;
  }

  /** Never silently lose a quest or achievement reward when the inventory is full. */
  public static void giveOrDrop(Player player, ItemStack stack) {
    if (stack == null || stack.getType().isAir() || stack.getAmount() <= 0) return;
    player.getInventory().addItem(stack).values().forEach(leftover -> player.getWorld().dropItemNaturally(player.getLocation(), leftover));
  }

  public static void remove(Player player, Material material, int amount) {
    ItemStack[] items = player.getInventory().getContents();
    for (int slot = 0; slot < items.length && amount > 0; slot++) {
      ItemStack item = items[slot];
      if (item == null || item.getType() != material) continue;
      int take = Math.min(amount, item.getAmount());
      amount -= take;
      if (take == item.getAmount()) player.getInventory().setItem(slot, null);
      else item.setAmount(item.getAmount() - take);
    }
  }

  public static int countMatching(Player player, java.util.function.Predicate<Material> predicate) {
    int total=0;for(ItemStack item:player.getInventory().getContents())if(item!=null&&predicate.test(item.getType()))total+=item.getAmount();return total;
  }

  public static boolean payMatching(Player player, java.util.function.Predicate<Material> predicate, int amount) {
    if(countMatching(player,predicate)<amount)return false;ItemStack[] items=player.getInventory().getContents();for(int slot=0;slot<items.length&&amount>0;slot++){ItemStack item=items[slot];if(item==null||!predicate.test(item.getType()))continue;int take=Math.min(amount,item.getAmount());amount-=take;if(take==item.getAmount())player.getInventory().setItem(slot,null);else item.setAmount(item.getAmount()-take);}return true;
  }

  public static Map<Material, Integer> cost(Object... pairs) {
    Map<Material, Integer> result = new LinkedHashMap<>();
    for (int i = 0; i < pairs.length; i += 2) result.put((Material) pairs[i], (Integer) pairs[i + 1]);
    return result;
  }
}
