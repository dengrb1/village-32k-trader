# VillageTrader 数据包版帮助

## 1. 适用环境

- Minecraft Java 26.1.2。
- 数据包格式：101.1。
- Vanilla、Paper 等能加载原版数据包的服务端均可使用。
- 数据包版不需要插件，但不能与 VillageTrader Paper 插件版同时运行。

数据包版适合单个世界内长期游玩。它使用世界计分板、玩家标签、命令存储和实体数据保存进度，不生成独立 JSON 档案。

## 2. 安装

将数据包文件夹或发行 ZIP 放入：

```text
<世界目录>/datapacks/
```

ZIP 或文件夹的第一层必须直接包含：

```text
pack.mcmeta
data/
```

进入世界后执行：

```text
/reload
```

然后用 `/datapack list enabled` 确认数据包已启用。加载成功后进入自然村庄，附近会生成 9×9 商店房屋；160 格内不会重复生成。

如果服务器已安装 VillageTrader 插件，请先停服并移除插件 JAR，再启用数据包。

## 3. 打开商店

- 右键商店屋内的成长商人。
- 在商人 6 格内执行 `/trigger vt_menu set 1`。
- 已登记并持有本人便携钥匙时，可在任意地点执行相同 trigger 或直接使用钥匙。

数据包版使用 Minecraft 26.1.2 原版 Dialog 展示分类、商品、任务、教程和设置。所有购买都会再次检查阶段、材料、任务状态、距离和物品所有权。

管理员向当前执行玩家发放或补发钥匙：

```mcfunction
execute as <玩家> run function village_trader:portable/grant
```

钥匙权限登记在玩家计分板中。把钥匙交给其他玩家不会转移权限。

## 4. 任务与 Boss 栏

任务只有在购买并激活对应任务牌后才开始计数。常驻个人 Boss 栏会显示：

- 未激活时：当前路线、阶段及购买任务牌提示。
- 激活后：各项目标实时数值和总体进度。
- 全部达标时：绿色“可提交”状态。
- 儿童线切换、暂停、毕业、Boss 番外和升格状态。

每名玩家使用独立的动态 Boss 栏编号，多人之间不会共享标题或进度。旧存档升级后会在玩家首次刷新时自动补分配栏位。

## 5. 主线说明

主线共有十个阶段：

1. 定居启程：制作工作台并睡一晚。
2. 矿脉勘探：挖掘钻石矿并击杀敌对生物。
3. 下界远征：进入下界、击杀烈焰人并挖掘远古残骸。
4. 沧海巡航：击杀远古守卫者并制作潮涌核心。
5. 末地远征：进入末地并击杀末影龙。
6. 村庄守卫：亲自赢得袭击并在激活后拾取图腾。
7. 试炼密室：击杀旋风人并使用试炼钥匙。
8. 凋灵攻坚：击杀凋灵并制作信标。
9. 深暗净化：击杀监守者并拾取回响碎片。
10. 龙魂再临：使用四枚末地水晶并再次击杀末影龙。

晋级时必须同时满足目标并持有本人登记的正确任务道具。提交会消耗任务道具；任务道具丢失后可免费补领一次。

旧版六阶段数据会在玩家首次刷新时迁移一次：已有进度映射到对应新章，进行中的旧任务转为对应新章的免费激活契约，旧版 64/255 装备权限以迁移标签保留。迁移只自动回填旧状态能够可靠证明的成就。

## 5.1 成就档案

商店与原版进度界面均提供 40 项成就：剧情 10、探索 8、战斗 8、商会 7、守护 7。每项完成会显示原版进度提示；总成就数决定仅在菜单与状态提示中显示的称号等级，不会修改聊天名。分类满额后可在商店领取一次奖励包，40 项全部完成会获得“终焉传奇”旗帜。

## 6. 儿童守护线

管理员命令：

```mcfunction
execute as <玩家> run function village_trader:child/enable
execute as <玩家> run function village_trader:child/disable
execute as <玩家> run function village_trader:child/reset
execute as <玩家> run function village_trader:child/status
```

- `enable`：启用并保留原进度。
- `disable`：暂停儿童线并恢复主线，不删除进度。
- `reset`：只重置儿童六章、Boss、印记、辅助用品和升格记录。
- `status`：显示当前儿童线状态。

六章完成后依次开放末影龙、凋灵和监守者番外。三个印记完成后可提交升格核心，解锁 128 级装备和危险生命急救。

## 7. 制裁与其他管理函数

全局制裁等级：

```mcfunction
function village_trader:penalty/normal
function village_trader:penalty/mild
function village_trader:penalty/severe
function village_trader:penalty/extreme
```

其他管理入口：

```mcfunction
function village_trader:create
function village_trader:spawn_merchant
function village_trader:uninstall
```

- `create`：在当前位置东侧附近尝试建造商店。
- `spawn_merchant`：在当前位置补一个成长商人。
- `uninstall`：停止调度并清除商人、锚点、Boss 栏、个人进度和计分板。

`uninstall` 不会拆除已经生成的房屋方块。执行后无法依靠数据包自动恢复玩家进度，使用前必须备份世界。

## 8. 夜视 API

以下函数以目标玩家为执行者：

```text
village_trader:api/night_vision/pause_3s
village_trader:api/night_vision/pause_10s
village_trader:api/night_vision/suspend_safe
village_trader:api/night_vision/suspend
village_trader:api/night_vision/resume
village_trader:api/night_vision/refresh
village_trader:api/night_vision/status
```

`suspend_safe` 只停止续期，当前夜视会自然结束；`suspend` 会主动清除夜视。

## 9. 存档与备份

数据包进度保存在世界自身的数据文件中，包括计分板、命令存储、玩家标签和实体数据。服务器正常保存世界时会一起保存，不需要额外保存命令。

升级或维护前至少备份：

```text
<世界目录>/data/
<世界目录>/playerdata/
<世界目录>/datapacks/
```

最稳妥的方式是停服后复制整个世界目录。

纯数据包不能安全读写服务器任意 JSON 文件，因此不支持按 UUID 导出、导入或跨服务器恢复单名玩家。如果需要这些能力，应迁移到 Paper 插件版。

## 10. 更新数据包

1. 停服并备份世界。
2. 用新版文件夹或 ZIP 替换旧数据包文件。
3. 启动服务器并执行 `/reload`。
4. 检查绿色加载消息、商人、个人 Boss 栏和现有阶段。

正常更新不要运行 `uninstall`。加载函数只补充缺失目标和公共值，不会主动重置已有玩家进度。

## 11. 常见问题

### `/reload` 后商店打不开

- 检查服务端日志是否出现函数或 Dialog 资源加载错误。
- 确认 ZIP 根目录没有额外套一层文件夹。
- 执行 `/datapack list enabled` 确认数据包处于启用状态。

### 进入村庄不建房

- 必须是原版能够识别的自然村庄。
- 160 格内已有商店锚点时不会重复生成。
- 可在测试世界执行 `/function village_trader:create` 手动验证建造逻辑。

### 任务不增加

- 确认任务牌已购买并激活。
- 确认当前没有切换到另一条路线。
- 历史统计只用于计算激活后的增量，激活前行为不会直接完成任务。

### Boss 栏不出现

- 等待最多一秒让个人栏位完成分配。
- 重新登录或执行 `/reload`。
- 检查 `vt_barid` 和相关计分板是否被其他管理工具删除。

### 商人死亡

约 5 秒后会补回，并提升全局制裁等级。反复用外部清理插件删除商人会持续触发制裁。

## 12. 从数据包迁移到插件

不要执行 `village_trader:uninstall`。停服备份后移除数据包、安装插件，并让玩家逐一登录。插件会在 JSON 不存在时读取遗留的 `vt_*` 计分板、标签和物品，生成一次性迁移档案。

迁移完成后使用插件的 `profile status` 和 `profile export` 检查并备份个人档案。
