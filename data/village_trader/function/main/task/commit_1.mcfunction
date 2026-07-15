clear @s minecraft:iron_ingot 16
clear @s minecraft:coal 8
function village_trader:purchase/pay_surcharge
function village_trader:main/task/give_1
scoreboard players set @s vt_qown 1
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 1
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players add @s vt_mdia 0
scoreboard players add @s vt_mddia 0
scoreboard players operation @s vt_bdia = @s vt_mdia
scoreboard players operation @s vt_bddia = @s vt_mddia
title @s actionbar [{"text":"[村庄商人] 已兑换并激活「矿工试炼证」。从现在开始记录目标。","color":"green"}]
function village_trader:main/menu/task
