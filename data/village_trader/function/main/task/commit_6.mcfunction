clear @s minecraft:echo_shard 8
clear @s minecraft:sculk_catalyst 1
clear @s minecraft:totem_of_undying 1
function village_trader:purchase/pay_surcharge
function village_trader:main/task/give_6
scoreboard players set @s vt_qown 6
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 6
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
title @s actionbar [{"text":"[村庄商人] 已兑换并激活「深暗挑战书」。从现在开始记录目标。","color":"green"}]
function village_trader:main/menu/task

