# VillageTrader Paper 插件

这是数据包玩法的独立 Paper 实现。运行时不再调用 `data/village_trader` 中的函数；旧数据包目录仅用于核对行为和玩家首次登录时读取遗留计分板/标签。

完整安装、迁移、命令、备份恢复和故障排查见 [`docs/HELP_PLUGIN.md`](docs/HELP_PLUGIN.md)。

## 构建与安装

- 服务端：Paper `26.1.2`，建议构建 `74-stable` 或兼容更新构建。
- Java：25。
- 构建：`./gradlew clean build`（Windows 使用 `gradlew.bat clean build`）。Gradle Toolchain 会在本机没有 Java 25 时自动下载匹配 JDK。
- 产物：`build/libs/VillageTrader-2.1.jar`（v2.1）。
- 将 JAR 放入 `plugins/`，首次启动后编辑 `plugins/VillageTrader/config.yml` 的 `enabled-worlds`，再重启服务器。

## v2.1 成长商店同步

- 十章主线现在每章有 3–4 项独立委托；新增熔铁、红石矿、猪灵、海底神殿、末地城、劫掠兽、沼骸、凋灵骷髅头、远古城市和龙息目标。`/vt progress` 可在任意地点查看十章状态与当前委托进度。
- 商店增加成就档案：剧情 10 项、探索 8 项、战斗 8 项、商会 7 项、守护 7 项，共 40 项；每个分类集齐后可领取一次补给，40/40 解锁“终焉传奇”旗帜与称号。
- 主线装备按 5/10/20/32/64/255 阶解锁，儿童守护装备按 1/3/5/10/20/32/128 阶解锁。首次兑换只购买等级通行证；之后按护甲、近战、工具、远程与功能分类免费补领单件。装备可损耗，并保留耐久和经验修补。
- 主线资源与消耗品扩充至 30 种，逐项显示一包价格和阶段条件；提供 1/16/64 包快捷购买，以及原子化的 `/vt buy <商品ID> <1-64>` 自定义购买。四档制裁价格照常生效。
- 主线辅助用品扩充到八件，新增建造者护符（主世界急迫 II、缓降）与旅行者护符（速度、抗性）；菜单显示登记、选中、携带和生效状态，状态变化时才提示。
- 旧 JSON 档案会自动备份并迁移到 schema 3：保留旧装备与进度，并为当前已解锁的最高主线/儿童等级补发通行证。

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
4. 让玩家逐一登录。没有 JSON 档案的玩家会从 `vt_*`、持久标签和旧物品生成一次性档案；新版数据包的成就标签和分类领奖记录也会保留。
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
`/vt progress` 打开只读十章进度；`/vt buy <商品ID> <1-64>` 购买主线商品包。
