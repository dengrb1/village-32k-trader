# VillageTrader Paper 插件

这是数据包玩法的独立 Paper 实现。运行时不再调用 `data/village_trader` 中的函数；旧数据包目录仅用于核对行为和玩家首次登录时读取遗留计分板/标签。

完整安装、迁移、命令、备份恢复和故障排查见 [`docs/HELP_PLUGIN.md`](docs/HELP_PLUGIN.md)。

## 构建与安装

- 服务端：Paper `26.1.2`，建议构建 `74-stable` 或兼容更新构建。
- Java：25。
- 构建：`./gradlew clean build`（Windows 使用 `gradlew.bat clean build`）。Gradle Toolchain 会在本机没有 Java 25 时自动下载匹配 JDK。
- 产物：`build/libs/VillageTrader-1.1.jar`（v1.1）。
- 将 JAR 放入 `plugins/`，首次启动后编辑 `plugins/VillageTrader/config.yml` 的 `enabled-worlds`，再重启服务器。

## 数据安全

- 玩家档案：`plugins/VillageTrader/profiles/<UUID>.json`。
- 全局状态：`plugins/VillageTrader/server-state.json`。
- 导出：`plugins/VillageTrader/exports/`。
- 迁移和导入前备份：`plugins/VillageTrader/backups/`。
- 保存采用主线程快照、单独写线程、临时文件和原子替换。损坏档案会锁定写入，不会用默认值覆盖。

## 升级旧世界

1. 停服并备份世界。
2. 移除旧 VillageTrader 数据包（不要先执行卸载函数，否则会删除迁移所需计分板和标签）。
3. 安装插件并启动。
4. 让玩家逐一登录。没有 JSON 档案的玩家会从 `vt_*`、持久标签和旧物品生成一次性档案。
5. 检查 `/vt profile status <玩家>`，再用 `/vt profile export <玩家>` 制作可迁移快照。

后续登录始终以 JSON 为权威，旧计分板不会再参与运行。

## 管理命令

- `/vt profile export <player>`
- `/vt profile import <player> <exports内文件名>`
- `/vt profile status <player>`
- `/vt key grant <player>`
- `/vt child enable|disable|reset|status <player>`
- `/vt penalty normal|mild|severe|extreme|status`
- `/vt shop create`
- `/vt nightvision suspend|resume|status <player>`

玩家使用 `/vt open` 打开个人库存 GUI，也可右键成长商人或本人绑定钥匙。
