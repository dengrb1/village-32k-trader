clear @s minecraft:emerald 16
clear @s minecraft:ominous_bottle 1
function village_trader:purchase/pay_surcharge
function village_trader:main/task/give_4
scoreboard players set @s vt_qown 4
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 4
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players operation @s vt_btotem = @s vt_ptotem
title @s actionbar [{"text":"[村庄商人] 已兑换并激活「村庄守卫令」。从现在开始记录目标。","color":"green"}]
function village_trader:main/menu/task
