scoreboard players set @s vt_ok 1
execute unless score @s vt_stage matches 4 run scoreboard players set @s vt_ok 0
execute unless score @s vt_qown matches 4 run scoreboard players set @s vt_ok 0
execute unless score @s vt_qrep matches 0 run scoreboard players set @s vt_ok 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:4}] 0
execute if score @s vt_tmp matches 1.. run scoreboard players set @s vt_ok 0
execute if score @s vt_ok matches 1 run function village_trader:main/task/give_4
execute if score @s vt_ok matches 1 run scoreboard players set @s vt_qrep 1
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已免费补领一次「村庄守卫令」。再次丢失将不再补领。","color":"aqua"}]
execute if score @s vt_ok matches 0 if score @s vt_qrep matches 1 run title @s actionbar [{"text":"[村庄商人] 本任务的免费补领次数已经使用。","color":"red"}]
execute if score @s vt_ok matches 0 if score @s vt_qrep matches 0 if score @s vt_tmp matches 1.. run title @s actionbar [{"text":"[村庄商人] 正确任务道具仍在身上，无需补领。","color":"yellow"}]

