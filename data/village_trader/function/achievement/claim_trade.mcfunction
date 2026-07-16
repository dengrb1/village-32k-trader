execute unless score @s vt_ach_trade matches 7.. run title @s actionbar [{"text":"[成就] 商会类尚未集齐（7 项）。","color":"red"}]
execute unless score @s vt_ach_trade matches 7.. run return 0
execute if entity @s[tag=village_trader.achievement_bundle_trade] run title @s actionbar [{"text":"[成就] 商会补给已领取。","color":"yellow"}]
execute if entity @s[tag=village_trader.achievement_bundle_trade] run return 0
tag @s add village_trader.achievement_bundle_trade
give @s minecraft:emerald 32
give @s minecraft:netherite_ingot 2
title @s actionbar [{"text":"[成就] 已领取商会补给。","color":"green"}]
