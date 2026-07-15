# 2.0 十章主线迁移：仅对已有 vt_init、但尚未写入版本的玩家执行一次。
# 保留原始快照，旧任务牌转换为对应新章节的免费契约；旧高阶装备权限另以标签永久保留。
scoreboard players operation @s vt_legacy_stage = @s vt_stage
scoreboard players operation @s vt_legacy_active = @s vt_qactive
advancement grant @s only village_trader:achievements/root
# 旧任务牌不再与新章编号共用；将本人持有的旧牌清理并转换为免费契约，避免误提交或占用背包。
execute if score @s vt_legacy_active matches 1 run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:1}] 1
execute if score @s vt_legacy_active matches 2 run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:2}] 1
execute if score @s vt_legacy_active matches 3 run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:3}] 1
execute if score @s vt_legacy_active matches 4 run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:4}] 1
execute if score @s vt_legacy_active matches 5 run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:5}] 1
execute if score @s vt_legacy_active matches 6 run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:6}] 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_ui_pending 0
scoreboard players set @s vt_ui_delay 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0

# 旧阶段代表已完成上一张旧任务牌，映射到其后第一个尚未重做的章节。
execute if score @s vt_legacy_stage matches 1 run scoreboard players set @s vt_stage 1
execute if score @s vt_legacy_stage matches 2 run scoreboard players set @s vt_stage 3
execute if score @s vt_legacy_stage matches 3 run scoreboard players set @s vt_stage 4
execute if score @s vt_legacy_stage matches 4 run scoreboard players set @s vt_stage 6
execute if score @s vt_legacy_stage matches 5 run scoreboard players set @s vt_stage 7
execute if score @s vt_legacy_stage matches 6 run scoreboard players set @s vt_stage 9

# 正在进行的旧任务不给出虚假完成记录，只换成进入相应新章节的一次免费激活资格。
execute if score @s vt_legacy_active matches 1 run scoreboard players set @s vt_stage 2
execute if score @s vt_legacy_active matches 1 run tag @s add village_trader.legacy_contract_2
execute if score @s vt_legacy_active matches 2 run scoreboard players set @s vt_stage 3
execute if score @s vt_legacy_active matches 2 run tag @s add village_trader.legacy_contract_3
execute if score @s vt_legacy_active matches 3 run scoreboard players set @s vt_stage 5
execute if score @s vt_legacy_active matches 3 run tag @s add village_trader.legacy_contract_5
execute if score @s vt_legacy_active matches 4 run scoreboard players set @s vt_stage 6
execute if score @s vt_legacy_active matches 4 run tag @s add village_trader.legacy_contract_6
execute if score @s vt_legacy_active matches 5 run scoreboard players set @s vt_stage 8
execute if score @s vt_legacy_active matches 5 run tag @s add village_trader.legacy_contract_8
execute if score @s vt_legacy_active matches 6 run scoreboard players set @s vt_stage 9
execute if score @s vt_legacy_active matches 6 run tag @s add village_trader.legacy_contract_9

# 旧困难终局已完成：保留 255 权限，并让玩家从“龙魂再临”开始新结局。
execute if score @s vt_legacy_active matches 7 run scoreboard players set @s vt_stage 10
execute if score @s vt_legacy_active matches 7 run tag @s add village_trader.legacy_255
execute if score @s vt_legacy_active matches 7 run tag @s add village_trader.legacy_64
execute if score @s vt_legacy_stage matches 6 run tag @s add village_trader.legacy_64

# 只回填能从旧阶段可靠证明的故事进度；新海洋、试炼及复苏目标均需亲自完成。
execute if score @s vt_legacy_stage matches 2.. run advancement grant @s only village_trader:achievements/story_02
execute if score @s vt_legacy_stage matches 3.. run advancement grant @s only village_trader:achievements/story_03
execute if score @s vt_legacy_stage matches 4.. run advancement grant @s only village_trader:achievements/story_05
execute if score @s vt_legacy_stage matches 5.. run advancement grant @s only village_trader:achievements/story_06
execute if score @s vt_legacy_stage matches 6.. run advancement grant @s only village_trader:achievements/story_08
execute if score @s vt_legacy_active matches 7 run advancement grant @s only village_trader:achievements/story_09
# 儿童线、Boss 印记和升格状态是已持久化的可靠记录，也一并补入对应守护成就。
execute if score @s vt_cstage matches 2.. run advancement grant @s only village_trader:achievements/guardian_01
execute if score @s vt_cstage matches 4.. run advancement grant @s only village_trader:achievements/guardian_02
execute if score @s vt_cstage matches 7.. run advancement grant @s only village_trader:achievements/guardian_03
execute if entity @s[tag=village_trader.mark_dragon] run advancement grant @s only village_trader:achievements/guardian_04
execute if entity @s[tag=village_trader.mark_wither] run advancement grant @s only village_trader:achievements/guardian_05
execute if entity @s[tag=village_trader.mark_warden] run advancement grant @s only village_trader:achievements/guardian_06
execute if score @s vt_asc matches 1.. run advancement grant @s only village_trader:achievements/guardian_07
function village_trader:achievement/title/refresh
scoreboard players set @s vt_version 2
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"已迁移至十章主线：旧进度、已购辅助品和高阶装备权限均已保留。","color":"green"}]
