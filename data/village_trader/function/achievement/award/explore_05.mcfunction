execute if entity @s[tag=village_trader.ach.explore_05] run return 0
tag @s add village_trader.ach.explore_05
scoreboard players add @s vt_ach_total 1
scoreboard players add @s vt_ach_explore 1
title @s actionbar [{"text":"[成就·探索] 试炼密室","color":"aqua"}]
function village_trader:achievement/title/refresh
function village_trader:achievement/check_all
