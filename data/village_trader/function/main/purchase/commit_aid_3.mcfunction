clear @s minecraft:golden_apple 1
function village_trader:purchase/pay_surcharge
tag @s add village_trader.main_aux_3
scoreboard players set @s vt_aux 3
function village_trader:main/purchase/give_aid_3
title @s actionbar [{"text":"[村庄商人] 已购买并永久登记「末地护符」，同时设为当前辅助用品。","color":"green"}]

