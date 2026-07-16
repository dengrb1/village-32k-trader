execute if entity @s[tag=village_trader.ach.story_06] run return 0
tag @s add village_trader.ach.story_06
scoreboard players add @s vt_ach_total 1
scoreboard players add @s vt_ach_story 1
title @s actionbar [{"text":"[成就·剧情] 守卫家园","color":"gold"}]
function village_trader:achievement/title/refresh
function village_trader:achievement/check_all
