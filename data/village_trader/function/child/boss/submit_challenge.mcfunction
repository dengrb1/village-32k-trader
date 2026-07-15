execute unless score @s vt_cstage matches 7 run return 0
execute unless score @s vt_bstage matches 1..3 run return 0
execute unless score @s vt_bqown matches 1 run title @s actionbar {"text":"你没有当前挑战书的购买记录。","color":"red"}
execute unless score @s vt_bqown matches 1 run return 0
scoreboard players set @s vt_ok 0
execute if score @s vt_bstage matches 1 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_boss_quest",id:1}] 1
execute if score @s vt_bstage matches 2 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_boss_quest",id:2}] 1
execute if score @s vt_bstage matches 3 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_boss_quest",id:3}] 1
execute unless score @s vt_ok matches 1 run title @s actionbar {"text":"缺少当前章节的正确挑战书。","color":"red"}
execute unless score @s vt_ok matches 1 run return 0
scoreboard players set @s vt_bqown 0
scoreboard players set @s vt_bactive 1
title @s actionbar {"text":"挑战书已消耗，当前 Boss 章节已激活；死亡不会取消激活。","color":"gold"}

