execute unless score @s vt_ach_story matches 10.. run title @s actionbar [{"text":"[成就] 剧情类尚未集齐（10 项）。","color":"red"}]
execute unless score @s vt_ach_story matches 10.. run return 0
execute if entity @s[tag=village_trader.achievement_bundle_story] run title @s actionbar [{"text":"[成就] 剧情毕业补给已领取。","color":"yellow"}]
execute if entity @s[tag=village_trader.achievement_bundle_story] run return 0
tag @s add village_trader.achievement_bundle_story
give @s minecraft:firework_rocket 32
give @s minecraft:golden_apple 16
title @s actionbar [{"text":"[成就] 已领取剧情毕业补给。","color":"green"}]
