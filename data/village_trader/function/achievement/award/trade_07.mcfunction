execute if entity @s[tag=village_trader.ach.trade_07] run return 0
tag @s add village_trader.ach.trade_07
scoreboard players add @s vt_ach_total 1
scoreboard players add @s vt_ach_trade 1
title @s actionbar [{"text":"[成就·商会] 主宰签章","color":"green"}]
function village_trader:achievement/title/refresh
function village_trader:achievement/check_all
