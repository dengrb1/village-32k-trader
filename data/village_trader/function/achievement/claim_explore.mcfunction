execute unless score @s vt_ach_explore matches 8.. run title @s actionbar [{"text":"[成就] 探索类尚未集齐（8 项）。","color":"red"}]
execute unless score @s vt_ach_explore matches 8.. run return 0
execute if entity @s[tag=village_trader.achievement_bundle_explore] run title @s actionbar [{"text":"[成就] 探索补给已领取。","color":"yellow"}]
execute if entity @s[tag=village_trader.achievement_bundle_explore] run return 0
tag @s add village_trader.achievement_bundle_explore
give @s minecraft:spyglass 1
give @s minecraft:compass 1
give @s minecraft:ender_pearl 16
title @s actionbar [{"text":"[成就] 已领取探索补给。","color":"green"}]
