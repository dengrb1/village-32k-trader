execute unless score @s vt_stage matches 11.. run title @s actionbar [{"text":"[村庄商人] ","color":"gold"},{"text":"完成十章主线后才能切换困难。","color":"red"}]
execute unless score @s vt_stage matches 11.. run return 0
scoreboard players set @s vt_diff 1
scoreboard players set @s vt_gear 0
title @s actionbar [{"text":"[村庄商人] ","color":"gold"},{"text":"已切换为困难商店；已解锁装备不会回退。","color":"yellow"}]
scoreboard players set @s vt_ui 8
function village_trader:ui/queue_reopen

