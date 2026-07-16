clear @s minecraft:emerald 8
function village_trader:purchase/pay_surcharge
tag @s add village_trader.main_aux_1
scoreboard players set @s vt_aux 1
function village_trader:main/purchase/give_aid_1
give @s minecraft:torch 64
give @s minecraft:cooked_beef 16
title @s actionbar [{"text":"[村庄商人] 已购买并永久登记「矿工补给包」，同时设为当前辅助用品。","color":"green"}]

