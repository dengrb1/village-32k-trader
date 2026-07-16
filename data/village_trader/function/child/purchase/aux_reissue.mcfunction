scoreboard players set @s vt_ok 0
execute if score @s vt_tmp matches 1 if entity @s[tag=village_trader.child_aux_1] run scoreboard players set @s vt_ok 1
execute if score @s vt_tmp matches 2 if entity @s[tag=village_trader.child_aux_2] run scoreboard players set @s vt_ok 1
execute if score @s vt_tmp matches 3 if entity @s[tag=village_trader.child_aux_3] run scoreboard players set @s vt_ok 1
execute if score @s vt_tmp matches 4 if entity @s[tag=village_trader.child_aux_4] run scoreboard players set @s vt_ok 1
execute if score @s vt_tmp matches 5 if entity @s[tag=village_trader.child_aux_5] run scoreboard players set @s vt_ok 1
execute if score @s vt_tmp matches 6 if entity @s[tag=village_trader.child_aux_6] run scoreboard players set @s vt_ok 1
execute if score @s vt_tmp matches 7 if entity @s[tag=village_trader.child_aux_7] run scoreboard players set @s vt_ok 1
execute if score @s vt_tmp matches 8 if entity @s[tag=village_trader.child_aux_8] run scoreboard players set @s vt_ok 1
execute if score @s vt_tmp matches 9 if entity @s[tag=village_trader.child_aux_9] run scoreboard players set @s vt_ok 1
execute unless score @s vt_ok matches 1 run title @s actionbar {"text":"你尚未永久登记该辅助用品。","color":"red"}
execute unless score @s vt_ok matches 1 run return 0
scoreboard players set @s vt_ok 0
execute if score @s vt_tmp matches 1 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:1}] 0
execute if score @s vt_tmp matches 2 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:2}] 0
execute if score @s vt_tmp matches 3 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:3}] 0
execute if score @s vt_tmp matches 4 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:4}] 0
execute if score @s vt_tmp matches 5 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:5}] 0
execute if score @s vt_tmp matches 6 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:6}] 0
execute if score @s vt_tmp matches 7 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:7}] 0
execute if score @s vt_tmp matches 8 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:8}] 0
execute if score @s vt_tmp matches 9 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:9}] 0
execute if score @s vt_ok matches 1.. run title @s actionbar {"text":"该辅助用品仍在背包中。","color":"yellow"}
execute if score @s vt_ok matches 1.. run return 0
function village_trader:child/purchase/give_aux
title @s actionbar {"text":"辅助用品已补领；所有权记录保持不变。","color":"green"}

