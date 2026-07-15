execute unless entity @s[tag=village_trader.main_aux_6] run title @s actionbar [{"text":"[村庄商人] 尚未购买「幽匿护符」，不能补领。","color":"red"}]
execute unless entity @s[tag=village_trader.main_aux_6] run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:6}] 0
execute if score @s vt_tmp matches 1.. run title @s actionbar [{"text":"[村庄商人] 「幽匿护符」仍在身上，无需补领。","color":"yellow"}]
execute if score @s vt_tmp matches 1.. run return 0
function village_trader:main/purchase/give_aid_6
title @s actionbar [{"text":"[村庄商人] 已免费补领「幽匿护符」。","color":"aqua"}]
