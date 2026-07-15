execute if entity @s[tag=village_trader.ach.explore_07] run return 0
tag @s add village_trader.ach.explore_07
scoreboard players add @s vt_ach_total 1
scoreboard players add @s vt_ach_explore 1
title @s actionbar [{"text":"[成就·探索] 幽匿深渊","color":"aqua"}]
function village_trader:achievement/title/refresh
function village_trader:achievement/check_all
