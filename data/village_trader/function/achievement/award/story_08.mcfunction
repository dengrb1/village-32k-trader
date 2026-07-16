execute if entity @s[tag=village_trader.ach.story_08] run return 0
tag @s add village_trader.ach.story_08
scoreboard players add @s vt_ach_total 1
scoreboard players add @s vt_ach_story 1
title @s actionbar [{"text":"[成就·剧情] 凋灵终结","color":"gold"}]
function village_trader:achievement/title/refresh
function village_trader:achievement/check_all
