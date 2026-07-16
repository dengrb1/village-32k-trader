execute store result score @s vt_tmp run clear @s minecraft:emerald_block 0
execute unless score @s vt_tmp matches 4.. run title @s actionbar {"text":"凋灵挑战书需要4绿宝石块、2金苹果和1牛奶桶。","color":"red"}
execute unless score @s vt_tmp matches 4.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:golden_apple 0
execute unless score @s vt_tmp matches 2.. run title @s actionbar {"text":"凋灵挑战书需要4绿宝石块、2金苹果和1牛奶桶。","color":"red"}
execute unless score @s vt_tmp matches 2.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:milk_bucket 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"凋灵挑战书需要4绿宝石块、2金苹果和1牛奶桶。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
clear @s minecraft:emerald_block 4
clear @s minecraft:golden_apple 2
clear @s minecraft:milk_bucket 1
give @s minecraft:bucket 1
give @s minecraft:paper[minecraft:custom_name={text:"凋灵挑战书",color:"dark_gray",italic:false},minecraft:custom_data={kind:"child_boss_quest",id:2},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_ok 1

