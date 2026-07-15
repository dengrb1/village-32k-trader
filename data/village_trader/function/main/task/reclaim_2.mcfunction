scoreboard players set @s vt_ok 1
execute unless score @s vt_stage matches 2 run scoreboard players set @s vt_ok 0
execute unless score @s vt_qown matches 2 run scoreboard players set @s vt_ok 0
execute unless score @s vt_qrep matches 0 run scoreboard players set @s vt_ok 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:2}] 0
execute if score @s vt_tmp matches 1.. run scoreboard players set @s vt_ok 0
execute if score @s vt_ok matches 1 run function village_trader:main/task/give_2
execute if score @s vt_ok matches 1 run scoreboard players set @s vt_qrep 1
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已免费补领一次「矿脉勘探证」。","color":"aqua"}]
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 无法补领：需为本章登记持有人、尚未补领且任务牌不在身上。","color":"red"}]
