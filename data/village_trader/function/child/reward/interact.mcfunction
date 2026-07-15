advancement revoke @s only village_trader:child/interact
execute if score @s vt_child matches 1 if score @s vt_cstage matches 6 if score @s vt_cactive matches 1 at @s if entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..4] run scoreboard players set @s vt_ca 1

