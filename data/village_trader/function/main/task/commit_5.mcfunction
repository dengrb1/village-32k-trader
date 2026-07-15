clear @s minecraft:soul_sand 4
clear @s minecraft:obsidian 8
clear @s minecraft:enchanted_golden_apple 1
function village_trader:purchase/pay_surcharge
function village_trader:main/task/give_5
scoreboard players set @s vt_qown 5
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 5
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
title @s actionbar [{"text":"[村庄商人] 已兑换并激活「凋灵挑战书」。从现在开始记录目标。","color":"green"}]
function village_trader:main/menu/task

