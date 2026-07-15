execute unless score @s vt_cqown matches 1 run title @s actionbar {"text":"你没有当前任务牌的个人所有权。","color":"red"}
execute unless score @s vt_cqown matches 1 run return 0
execute if score @s vt_cqrep matches 1 run title @s actionbar {"text":"当前任务牌的免费补领机会已经使用。","color":"red"}
execute if score @s vt_cqrep matches 1 run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:1}] 0
execute if score @s vt_cstage matches 2 store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:2}] 0
execute if score @s vt_cstage matches 3 store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:3}] 0
execute if score @s vt_cstage matches 4 store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:4}] 0
execute if score @s vt_cstage matches 5 store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:5}] 0
execute if score @s vt_cstage matches 6 store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:6}] 0
execute if score @s vt_tmp matches 1.. run title @s actionbar {"text":"当前任务牌仍在背包中，不能补领。","color":"yellow"}
execute if score @s vt_tmp matches 1.. run return 0
function village_trader:child/task/give_current
scoreboard players set @s vt_cqrep 1
title @s actionbar {"text":"已免费补领当前任务牌；本章不能再次补领。","color":"green"}

