scoreboard players set @s vt_ok 0
tag @s add village_trader.effect_target
execute as @e[type=#minecraft:raiders,distance=..64] if data entity @s RaidId run scoreboard players set @a[tag=village_trader.effect_target,limit=1] vt_ok 1
tag @s remove village_trader.effect_target
execute unless score @s vt_ok matches 1 run scoreboard players set @s vt_tmp 0
