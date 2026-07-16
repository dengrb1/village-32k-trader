clear @s minecraft:diamond 4
function village_trader:purchase/pay_surcharge
tag @s add village_trader.main_aux_2
scoreboard players set @s vt_aux 2
function village_trader:main/purchase/give_aid_2
title @s actionbar [{"text":"[村庄商人] 已购买并永久登记「下界护符」，同时设为当前辅助用品。","color":"green"}]

