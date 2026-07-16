execute unless score @s vt_ach_guardian matches 7.. run title @s actionbar [{"text":"[成就] 守护类尚未集齐（7 项）。","color":"red"}]
execute unless score @s vt_ach_guardian matches 7.. run return 0
execute if entity @s[tag=village_trader.achievement_bundle_guardian] run title @s actionbar [{"text":"[成就] 守护补给已领取。","color":"yellow"}]
execute if entity @s[tag=village_trader.achievement_bundle_guardian] run return 0
tag @s add village_trader.achievement_bundle_guardian
give @s minecraft:diamond 16
give @s minecraft:totem_of_undying 1
title @s actionbar [{"text":"[成就] 已领取守护补给。","color":"green"}]
