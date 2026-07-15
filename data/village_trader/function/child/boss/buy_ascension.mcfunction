execute unless score @s vt_cstage matches 7 run return 0
execute unless score @s vt_bstage matches 4 run return 0
execute if score @s vt_asc matches 1 run title @s actionbar {"text":"守护升格已经永久解锁。","color":"yellow"}
execute if score @s vt_asc matches 1 run return 0
execute unless entity @s[tag=village_trader.mark_dragon,tag=village_trader.mark_wither,tag=village_trader.mark_warden] run title @s actionbar {"text":"需要三个永久 Boss 印记。","color":"red"}
execute unless entity @s[tag=village_trader.mark_dragon,tag=village_trader.mark_wither,tag=village_trader.mark_warden] run return 0
execute if score @s vt_asckey matches 1 run function village_trader:child/boss/reissue_ascension
execute if score @s vt_asckey matches 1 run return 1
execute store result score @s vt_tmp run clear @s minecraft:diamond 0
execute unless score @s vt_tmp matches 16.. run title @s actionbar {"text":"守护升格核心需要16钻石和4下界合金锭。","color":"red"}
execute unless score @s vt_tmp matches 16.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:netherite_ingot 0
execute unless score @s vt_tmp matches 4.. run title @s actionbar {"text":"守护升格核心需要16钻石和4下界合金锭。","color":"red"}
execute unless score @s vt_tmp matches 4.. run return 0
clear @s minecraft:diamond 16
clear @s minecraft:netherite_ingot 4
give @s minecraft:paper[minecraft:custom_name='{"text":"守护升格核心","color":"aqua","bold":true,"italic":false}',minecraft:custom_data={kind:"child_ascension_core",id:1},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_asckey 1
scoreboard players set @s vt_cqrep 0
title @s actionbar {"text":"升格核心已兑换；请提交以永久解锁128级守护装备。","color":"green"}
