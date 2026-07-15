# 先发放/提示当前守护装备，再延迟恢复装备页，避免动作栏结果被 Dialog 遮住。
execute if score @s vt_asc matches 1 run function village_trader:child/equipment/tier_128
execute if score @s vt_asc matches 1 run scoreboard players set @s vt_ui 30
execute if score @s vt_asc matches 1 run function village_trader:ui/queue_reopen
execute if score @s vt_asc matches 1 run return 1
execute if score @s vt_cstage matches 1 run function village_trader:child/equipment/tier_1
execute if score @s vt_cstage matches 2 run function village_trader:child/equipment/tier_3
execute if score @s vt_cstage matches 3 run function village_trader:child/equipment/tier_5
execute if score @s vt_cstage matches 4 run function village_trader:child/equipment/tier_10
execute if score @s vt_cstage matches 5 run function village_trader:child/equipment/tier_20
execute if score @s vt_cstage matches 6..7 run function village_trader:child/equipment/tier_32
scoreboard players set @s vt_ui 30
function village_trader:ui/queue_reopen
