execute unless score @s vt_ach_combat matches 8.. run title @s actionbar [{"text":"[成就] 战斗类尚未集齐（8 项）。","color":"red"}]
execute unless score @s vt_ach_combat matches 8.. run return 0
execute if entity @s[tag=village_trader.achievement_bundle_combat] run title @s actionbar [{"text":"[成就] 战斗补给已领取。","color":"yellow"}]
execute if entity @s[tag=village_trader.achievement_bundle_combat] run return 0
tag @s add village_trader.achievement_bundle_combat
give @s minecraft:totem_of_undying 2
give @s minecraft:golden_apple 16
title @s actionbar [{"text":"[成就] 已领取战斗补给。","color":"green"}]
