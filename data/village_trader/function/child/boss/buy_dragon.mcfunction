execute store result score @s vt_tmp run clear @s minecraft:diamond 0
execute unless score @s vt_tmp matches 8.. run title @s actionbar {"text":"龙之挑战书需要8钻石和2金苹果。","color":"red"}
execute unless score @s vt_tmp matches 8.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:golden_apple 0
execute unless score @s vt_tmp matches 2.. run title @s actionbar {"text":"龙之挑战书需要8钻石和2金苹果。","color":"red"}
execute unless score @s vt_tmp matches 2.. run return 0
clear @s minecraft:diamond 8
clear @s minecraft:golden_apple 2
give @s minecraft:paper[minecraft:custom_name='{"text":"龙之挑战书","color":"light_purple","italic":false}',minecraft:custom_data={kind:"child_boss_quest",id:1},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_ok 1

