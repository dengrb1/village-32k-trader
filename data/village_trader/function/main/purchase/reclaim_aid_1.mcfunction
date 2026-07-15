execute unless entity @s[tag=village_trader.main_aux_1] run title @s actionbar [{"text":"[村庄商人] 尚未购买「矿工补给包」，不能补领。","color":"red"}]
execute unless entity @s[tag=village_trader.main_aux_1] run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:1}] 0
execute if score @s vt_tmp matches 1.. run title @s actionbar [{"text":"[村庄商人] 「矿工补给包」仍在身上，无需补领。","color":"yellow"}]
execute if score @s vt_tmp matches 1.. run return 0
function village_trader:main/purchase/give_aid_1
title @s actionbar [{"text":"[村庄商人] 已免费补领「矿工补给包」。","color":"aqua"}]
