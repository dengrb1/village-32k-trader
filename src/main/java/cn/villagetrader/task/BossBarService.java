package cn.villagetrader.task;

import cn.villagetrader.model.PlayerProfile;
import cn.villagetrader.storage.ProfileManager;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import net.kyori.adventure.bossbar.BossBar;
import net.kyori.adventure.text.Component;
import net.kyori.adventure.text.format.NamedTextColor;
import org.bukkit.Bukkit;
import org.bukkit.entity.Player;

public final class BossBarService {
  private final ProfileManager profiles;
  private final TaskService tasks;
  private final Map<UUID, BossBar> bars = new HashMap<>();

  public BossBarService(ProfileManager profiles, TaskService tasks) { this.profiles = profiles; this.tasks = tasks; }

  public void updateAll() { for (Player player : Bukkit.getOnlinePlayers()) update(player); }

  public void update(Player player) {
    PlayerProfile p = profiles.get(player.getUniqueId());
    if (p == null) return;
    tasks.refreshHeldGoals(player, p);
    RouteState selected = select(p);
    Component title;
    float progress;
    BossBar.Color color;
    if (selected.task.activeId == 0) {
      title = Component.text(selected.routeLabel + " · 阶段 " + selected.stage + " · 购买并激活任务牌", NamedTextColor.YELLOW);
      progress = 0f;
      color = BossBar.Color.YELLOW;
    } else {
      TaskDefinitions.Definition definition = TaskDefinitions.get(selected.route, selected.task.activeId);
      int total = 0;
      int done = 0;
      StringBuilder goals = new StringBuilder();
      for (TaskDefinitions.Goal goal : definition.goals().values()) {
        int current = Math.min(goal.target(), selected.task.progress.getOrDefault(goal.key(), 0));
        total += goal.target(); done += current;
        if (!goals.isEmpty()) goals.append(" | ");
        goals.append(goal.label()).append(' ').append(current).append('/').append(goal.target());
      }
      boolean complete = total > 0 && done >= total;
      title = Component.text((complete ? "可提交 · " : "") + definition.name() + " · " + goals, complete ? NamedTextColor.GREEN : NamedTextColor.WHITE);
      progress = total == 0 ? 0 : Math.min(1f, (float) done / total);
      color = complete ? BossBar.Color.GREEN : (selected.route == TaskDefinitions.Route.CHILD ? BossBar.Color.BLUE : BossBar.Color.PURPLE);
    }
    BossBar bar = bars.computeIfAbsent(player.getUniqueId(), ignored -> BossBar.bossBar(title, progress, color, BossBar.Overlay.PROGRESS));
    bar.name(title); bar.progress(progress); bar.color(color);
    player.showBossBar(bar);
  }

  public void hide(Player player) {
    BossBar bar = bars.remove(player.getUniqueId());
    if (bar != null) player.hideBossBar(bar);
  }

  public void close() { for (Player player : Bukkit.getOnlinePlayers()) hide(player); }

  private RouteState select(PlayerProfile p) {
    if (p.child.enabled) {
      if (p.child.stage >= 7 && p.child.bossStage <= 3) return new RouteState(TaskDefinitions.Route.BOSS, "Boss番外", p.child.bossStage, p.child.bossTask);
      return new RouteState(TaskDefinitions.Route.CHILD, "儿童守护线", p.child.stage, p.child.task);
    }
    return new RouteState(TaskDefinitions.Route.MAIN, p.main.hardMode ? "主线·困难" : "主线", p.main.stage, p.main.task);
  }

  private record RouteState(TaskDefinitions.Route route, String routeLabel, int stage, PlayerProfile.Task task) {}
}
