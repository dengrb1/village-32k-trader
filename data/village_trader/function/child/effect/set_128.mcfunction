effect give @s minecraft:resistance 3 2 true
effect give @s minecraft:regeneration 3 3 true
effect give @s minecraft:absorption 3 3 true
effect give @s minecraft:fire_resistance 3 0 true
effect give @s minecraft:water_breathing 3 0 true
effect give @s minecraft:slow_falling 3 0 true
execute store result score @s vt_tmp run data get entity @s Health 1
execute if score @s vt_tmp matches ..8 if score @s vt_healcd matches 0 run function village_trader:child/effect/emergency_heal

