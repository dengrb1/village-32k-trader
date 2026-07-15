# VillageTrader Paper 插件版帮助

## 1. 适用环境

- Minecraft Java 服务端：Paper 26.1.2，已验证构建为 `74-stable`。
- Java：25。
- 插件文件：`VillageTrader-1.1.jar`（v1.1）。
- 不支持 Vanilla 服务端，也不要与 VillageTrader 数据包版同时运行。

插件版适合需要库存 GUI、玩家 JSON 档案、跨服务器迁移、档案导入导出和按世界启用的服务器。

## 2. 构建与安装

在源码目录执行：

```powershell
.\gradlew.bat clean build --no-daemon
```

Linux 或 macOS 使用：

```bash
./gradlew clean build --no-daemon
```

构建产物位于 `build/libs/VillageTrader-1.1.jar`。

安装步骤：

1. 停止服务器。
2. 将 JAR 放入服务器的 `plugins/`。
3. 确认同一世界的 `datapacks/` 内没有启用 VillageTrader 数据包版。
4. 启动一次服务器，让插件生成配置和数据目录。
5. 编辑 `plugins/VillageTrader/config.yml`，然后重启。

## 3. 配置说明

```yaml
enabled-worlds: []
autosave-ticks: 9468
merchant-respawn-ticks: 100
shop-duplicate-radius: 160
village-scan-radius: 32
build-shop-house: true
bossbar:
  enabled: true
  update-ticks: 10
legacy-migration:
  enabled: true
  convert-items-on-join: true
```

- `enabled-worlds`：允许插件运行的世界名。留空时使用服务器第一个 `NORMAL` 世界；生产服建议显式填写。
- `autosave-ticks`：周期保存间隔，默认 9468 tick，即约 7.89 分钟。
- `merchant-respawn-ticks`：商人丢失后的补回延迟，默认 100 tick，即 5 秒。
- `shop-duplicate-radius`：商店建筑防重复半径，默认 160 格。
- `village-scan-radius`：自然村庄检测范围。
- `build-shop-house`：是否自动生成商店房屋。
- `bossbar.enabled`：是否显示个人常驻任务 Boss 栏。
- `bossbar.update-ticks`：Boss 栏刷新间隔。
- `legacy-migration.enabled`：没有 JSON 档案时，是否读取旧数据包遗留状态。
- `legacy-migration.convert-items-on-join`：是否在登录时识别并转换旧 `custom_data` 物品。

修改配置后应完整重启服务器，不建议用第三方热重载插件。

## 4. 玩家使用

- `/vt open`：打开个人商店库存 GUI。
- 右键成长商人：打开个人商店。
- 右键本人绑定的便携钥匙：在任意地点打开个人商店。

任务只有在购买并激活对应任务牌后才会计数。Boss 栏会显示当前路线、阶段、分项目标和总体完成度；全部达标后会变为绿色可提交状态。

任务牌、钥匙、辅助用品和装备带有插件 PDC 身份及所有者 UUID。把绑定物品交给其他玩家不会转移权限。

## 5. 管理命令

以下命令需要 OP 或 `villagetrader.admin` 权限。当前版本的玩家目标必须在线。

### 档案

```text
/vt profile export <玩家>
/vt profile import <玩家> <文件名>
/vt profile status <玩家>
```

- `export`：在 `plugins/VillageTrader/exports/` 创建带时间戳的完整 JSON 快照。
- `import`：只接受 `exports/` 目录内文件；schema 和 UUID 必须匹配目标玩家。
- `status`：显示 UUID、档案版本、更新时间和进度摘要。

### 玩法管理

```text
/vt key grant <玩家>
/vt child enable <玩家>
/vt child disable <玩家>
/vt child reset <玩家>
/vt child status <玩家>
/vt penalty normal
/vt penalty mild
/vt penalty severe
/vt penalty extreme
/vt penalty status
/vt shop create
/vt nightvision suspend <玩家>
/vt nightvision resume <玩家>
/vt nightvision status <玩家>
```

`child reset` 只重置儿童线、Boss、印记、辅助用品和升格记录，不修改主线。`shop create` 在命令执行者所在位置附近创建商店。

## 6. 从数据包版升级

1. 停服并备份整个世界。
2. 移除 VillageTrader 数据包，但不要先运行数据包的 `uninstall`，否则迁移需要的 `vt_*` 计分板和标签会被删除。
3. 安装插件并启用 `legacy-migration.enabled`。
4. 启动服务器，让玩家逐一登录。
5. 插件会在本地 JSON 不存在时读取旧计分板、标签和旧物品，生成一次性迁移档案。
6. 对每名玩家执行 `/vt profile status <玩家>` 和 `/vt profile export <玩家>`。
7. 确认迁移无误后再清理不再使用的旧数据包文件。

迁移完成后，JSON 是唯一权威进度来源。后续登录会用 JSON 状态覆盖旧计分板状态。

## 7. 档案、备份与跨服迁移

```text
plugins/VillageTrader/profiles/<UUID>.json
plugins/VillageTrader/server-state.json
plugins/VillageTrader/exports/
plugins/VillageTrader/backups/
```

- `profiles/`：个人主线、儿童线、任务、物品登记、钥匙和冷却。
- `server-state.json`：全局制裁、商店建筑和商人位置。
- `exports/`：管理员导出的可迁移快照。
- `backups/`：schema 迁移或导入前的自动备份。

跨服务器迁移：

1. 在原服务器执行 `profile export`。
2. 停服或确认导出完成。
3. 将导出 JSON 复制到目标服务器的 `exports/`。
4. 让相同 UUID 的玩家登录目标服务器。
5. 执行 `profile import`。

离线模式服务器可能因 UUID 生成规则不同导致无法导入，不要手工修改 JSON 中的 UUID 绕过校验。

## 8. 数据安全

- 关键进度变化、玩家退出、服务器停服和周期任务都会触发保存。
- 主线程只生成不可变快照，磁盘写入在单独线程完成。
- 写入使用临时文件和原子替换，避免损坏旧档。
- 档案解析或迁移失败后会锁定覆盖，原文件不会被默认进度替换。

发现档案错误时，先停服并复制 `profiles/`、`backups/` 和日志，再处理问题。不要直接删除损坏档案后让插件重建。

## 9. 常见问题

### `/vt open` 没反应

- 确认玩家位于 `enabled-worlds` 中允许的世界。
- 检查是否拥有 `villagetrader.use`。
- 查看控制台是否有档案解析失败或写入锁定提示。

### 商店不生成

- 确认当前世界在启用列表中并且环境为可用世界。
- 确认 `build-shop-house: true`。
- 玩家需要进入自然村庄检测范围。
- 160 格内已有记录时不会重复建房，可由 OP 使用 `/vt shop create` 验证。

### 任务不计数

- 确认对应任务牌已经购买并激活，而不只是放在背包里。
- 确认当前路线没有被暂停或切换。
- 主线袭击任务要求先亲自赢得袭击，再在任务激活后亲自拾取图腾。

### 导入被拒绝

- 文件必须位于 `exports/` 内。
- UUID 必须与目标玩家一致。
- schema 必须是插件支持的版本。
- 目标玩家必须在线。

## 10. 停用与回滚

停用前先执行玩家档案导出并备份整个 `plugins/VillageTrader/`。停服后移除 JAR 即可停止插件运行；世界内已经生成的房屋方块不会自动拆除。

如果要回滚到数据包版，数据包无法直接读取插件 JSON。只能恢复安装插件前的世界备份，或由管理员按实际进度手工恢复数据包计分板，不建议直接混装尝试转换。
