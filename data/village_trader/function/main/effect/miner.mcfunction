execute unless entity @s[tag=village_trader.main_aux_1] run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:1}] 0
execute if score @s vt_tmp matches 1.. run effect give @s minecraft:haste 3 0 true
