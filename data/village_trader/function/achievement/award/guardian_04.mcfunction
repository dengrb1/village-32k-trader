execute if entity @s[tag=village_trader.ach.guardian_04] run return 0
tag @s add village_trader.ach.guardian_04
scoreboard players add @s vt_ach_total 1
scoreboard players add @s vt_ach_guardian 1
title @s actionbar [{"text":"[成就·守护] 龙之印","color":"light_purple"}]
function village_trader:achievement/title/refresh
function village_trader:achievement/check_all
