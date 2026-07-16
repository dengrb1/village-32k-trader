clear @s minecraft:echo_shard 4
function village_trader:purchase/pay_surcharge
tag @s add village_trader.main_aux_6
scoreboard players set @s vt_aux 6
function village_trader:main/purchase/give_aid_6
title @s actionbar [{"text":"[村庄商人] 已购买并永久登记「幽匿护符」，同时设为当前辅助用品。","color":"green"}]

