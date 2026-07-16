clear @s minecraft:emerald 8
function village_trader:purchase/pay_surcharge
tag @s add village_trader.main_aux_7
scoreboard players set @s vt_aux 7
function village_trader:main/purchase/give_aid_7
title @s actionbar {"text":"已购买建造者护符，并设为当前辅助用品。","color":"green"}
