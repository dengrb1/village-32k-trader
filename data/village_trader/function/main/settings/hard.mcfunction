execute unless score @s vt_stage matches 6 run title @s actionbar [{"text":"[村庄商人] ","color":"gold"},{"text":"普通主线达到第六阶段后才能切换困难。","color":"red"}]
execute unless score @s vt_stage matches 6 run return 0
scoreboard players set @s vt_diff 1
scoreboard players set @s vt_gear 0
title @s actionbar [{"text":"[村庄商人] ","color":"gold"},{"text":"已切换为困难商店。深暗挑战完成前，当前装备按第五阶显示。","color":"yellow"}]
function village_trader:main/menu/settings

