scoreboard players set @s vt_ui 30
function village_trader:ui/open_current
execute if score @s vt_asc matches 1 run function village_trader:child/equipment/tier_128
execute if score @s vt_asc matches 1 run return 1
execute if score @s vt_cstage matches 1 run function village_trader:child/equipment/tier_1
execute if score @s vt_cstage matches 2 run function village_trader:child/equipment/tier_3
execute if score @s vt_cstage matches 3 run function village_trader:child/equipment/tier_5
execute if score @s vt_cstage matches 4 run function village_trader:child/equipment/tier_10
execute if score @s vt_cstage matches 5 run function village_trader:child/equipment/tier_20
execute if score @s vt_cstage matches 6..7 run function village_trader:child/equipment/tier_32
