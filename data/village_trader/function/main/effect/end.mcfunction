execute unless entity @s[tag=village_trader.main_aux_3] run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:3}] 0
execute if score @s vt_tmp matches 1.. if dimension minecraft:the_end run effect give @s minecraft:slow_falling 3 0 true
execute if score @s vt_tmp matches 1.. if dimension minecraft:the_end run effect give @s minecraft:regeneration 3 0 true
