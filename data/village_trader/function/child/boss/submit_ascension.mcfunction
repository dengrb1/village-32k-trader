execute unless score @s vt_asckey matches 1 run title @s actionbar {"text":"提交失败：你没有升格核心的所有权记录。","color":"red"}
execute unless score @s vt_asckey matches 1 run return 0
execute store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_ascension_core",id:1}] 1
execute unless score @s vt_ok matches 1 run title @s actionbar {"text":"提交失败：背包中没有守护升格核心。","color":"red"}
execute unless score @s vt_ok matches 1 run return 0
scoreboard players set @s vt_asckey 0
scoreboard players set @s vt_asc 1
advancement grant @s only village_trader:achievements/guardian_07
tellraw @s {"text":"守护升格完成！128级强化守护装备已永久解锁。","color":"light_purple","bold":true}
