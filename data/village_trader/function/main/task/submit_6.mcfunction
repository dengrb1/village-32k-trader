scoreboard players set @s vt_ok 1
execute unless score @s vt_stage matches 6 run scoreboard players set @s vt_ok 0
execute unless score @s vt_diff matches 1 run scoreboard players set @s vt_ok 0
execute unless score @s vt_qactive matches 6 run scoreboard players set @s vt_ok 0
execute unless score @s vt_qown matches 6 run scoreboard players set @s vt_ok 0
execute unless score @s vt_a matches 1.. run scoreboard players set @s vt_ok 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:6}] 0
execute if score @s vt_tmp matches 0 run scoreboard players set @s vt_ok 0
execute if score @s vt_ok matches 1 run function village_trader:main/task/complete_6
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 提交失败：本人所有权、正确任务道具和全部普通目标缺一不可。","color":"red"}]

