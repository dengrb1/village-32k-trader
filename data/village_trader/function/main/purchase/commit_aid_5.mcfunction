clear @s minecraft:diamond_block 1
function village_trader:purchase/pay_surcharge
tag @s add village_trader.main_aux_5
scoreboard players set @s vt_aux 5
function village_trader:main/purchase/give_aid_5
title @s actionbar [{"text":"[村庄商人] 已购买并永久登记「凋灵净化符」，同时设为当前辅助用品。","color":"green"}]

