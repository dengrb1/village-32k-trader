execute unless entity @s[tag=village_trader.main_aux_4] run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:4}] 0
execute unless score @s vt_tmp matches 1.. run return 0
scoreboard players set @s vt_ok 0
tag @s add village_trader.effect_target
execute as @e[type=#minecraft:raiders,distance=..64] if data entity @s RaidId run scoreboard players set @a[tag=village_trader.effect_target,limit=1] vt_ok 1
tag @s remove village_trader.effect_target
execute if score @s vt_ok matches 1 run effect give @s minecraft:resistance 3 0 true
execute if score @s vt_ok matches 1 run effect give @s minecraft:regeneration 3 0 true
