execute unless entity @s[tag=village_trader.main_aux_2] run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:2}] 0
execute if score @s vt_tmp matches 1.. if dimension minecraft:the_nether run effect give @s minecraft:fire_resistance 3 0 true
execute if score @s vt_tmp matches 1.. if dimension minecraft:the_nether run effect give @s minecraft:resistance 3 0 true
