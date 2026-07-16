execute store result score @s vt_ok run function village_trader:child/purchase/pay_dirt
execute unless score @s vt_ok matches 1 run return 0
tag @s add village_trader.child_pass_10
title @s actionbar {"text":"已购买 10 级儿童装备通行证；单件补领永久免费。","color":"green"}
function village_trader:child/equipment/pass_home
