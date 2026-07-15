clear @s minecraft:ender_pearl 12
clear @s minecraft:blaze_powder 12
function village_trader:purchase/pay_surcharge
function village_trader:main/task/give_3
scoreboard players set @s vt_qown 3
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 3
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
title @s actionbar [{"text":"[村庄商人] 已兑换并激活「末地追踪证」。从现在开始记录目标。","color":"green"}]
function village_trader:main/menu/task

