clear @s minecraft:obsidian 8
clear @s minecraft:flint_and_steel 1
clear @s minecraft:gold_ingot 4
function village_trader:purchase/pay_surcharge
function village_trader:main/task/give_2
scoreboard players set @s vt_qown 2
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 2
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players add @s vt_mdebris 0
scoreboard players operation @s vt_bdebris = @s vt_mdebris
title @s actionbar [{"text":"[村庄商人] 已兑换并激活「下界通行证」。从现在开始记录目标。","color":"green"}]
function village_trader:main/menu/task
