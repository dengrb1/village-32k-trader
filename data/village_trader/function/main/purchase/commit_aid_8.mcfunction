clear @s minecraft:diamond 2
function village_trader:purchase/pay_surcharge
tag @s add village_trader.main_aux_8
scoreboard players set @s vt_aux 8
function village_trader:main/purchase/give_aid_8
title @s actionbar {"text":"已购买旅行者护符，并设为当前辅助用品。","color":"green"}
