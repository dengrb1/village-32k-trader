execute unless entity @s[tag=village_trader.main_aux_6] run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:6}] 0
execute if score @s vt_tmp matches 1.. if predicate village_trader:main/in_deep_dark run effect give @s minecraft:speed 3 1 true
execute if score @s vt_tmp matches 1.. if predicate village_trader:main/in_deep_dark run effect give @s minecraft:resistance 3 1 true
execute if score @s vt_tmp matches 1.. if predicate village_trader:main/in_deep_dark run effect give @s minecraft:regeneration 3 0 true
