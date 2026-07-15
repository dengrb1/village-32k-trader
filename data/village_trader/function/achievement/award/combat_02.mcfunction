execute if entity @s[tag=village_trader.ach.combat_02] run return 0
tag @s add village_trader.ach.combat_02
scoreboard players add @s vt_ach_total 1
scoreboard players add @s vt_ach_combat 1
title @s actionbar [{"text":"[成就·战斗] 烈焰克星","color":"red"}]
function village_trader:achievement/title/refresh
function village_trader:achievement/check_all
