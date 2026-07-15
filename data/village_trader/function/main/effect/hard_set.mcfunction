# 255 级装备效果仅在困难商店中续期；旧版毕业玩家的迁移权限同样有效。
execute unless score @s vt_diff matches 1 run return 0
execute unless score @s vt_stage matches 11.. unless entity @s[tag=village_trader.legacy_255] run return 0
execute unless items entity @s armor.head minecraft:netherite_helmet[minecraft:custom_data~{kind:"main_equipment",tier:255}] run return 0
execute unless items entity @s armor.chest minecraft:netherite_chestplate[minecraft:custom_data~{kind:"main_equipment",tier:255}] run return 0
execute unless items entity @s armor.legs minecraft:netherite_leggings[minecraft:custom_data~{kind:"main_equipment",tier:255}] run return 0
execute unless items entity @s armor.feet minecraft:netherite_boots[minecraft:custom_data~{kind:"main_equipment",tier:255}] run return 0
effect give @s minecraft:resistance 3 3 true
effect give @s minecraft:regeneration 3 4 true
effect give @s minecraft:fire_resistance 3 0 true
effect give @s minecraft:water_breathing 3 0 true
effect give @s minecraft:strength 3 4 true
effect give @s minecraft:speed 3 1 true
