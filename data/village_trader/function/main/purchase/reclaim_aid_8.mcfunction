execute unless entity @s[tag=village_trader.main_aux_8] run title @s actionbar {"text":"尚未购买旅行者护符，不能补领。","color":"red"}
execute unless entity @s[tag=village_trader.main_aux_8] run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:8}] 0
execute if score @s vt_tmp matches 1.. run title @s actionbar {"text":"旅行者护符仍在身上，无需补领。","color":"yellow"}
execute if score @s vt_tmp matches 1.. run return 0
function village_trader:main/purchase/give_aid_8
title @s actionbar {"text":"已免费补领旅行者护符。","color":"aqua"}
