execute if score @s vt_cqrep matches 1 run title @s actionbar {"text":"当前 Boss 挑战书的免费补领次数已经用完。","color":"red"}
execute if score @s vt_cqrep matches 1 run return 0
scoreboard players set @s vt_tmp 0
execute if score @s vt_bstage matches 1 store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_boss_quest",id:1}] 0
execute if score @s vt_bstage matches 2 store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_boss_quest",id:2}] 0
execute if score @s vt_bstage matches 3 store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_boss_quest",id:3}] 0
execute if score @s vt_tmp matches 1.. run title @s actionbar {"text":"当前挑战书仍在背包中。","color":"yellow"}
execute if score @s vt_tmp matches 1.. run return 0
execute if score @s vt_bstage matches 1 run give @s minecraft:paper[minecraft:custom_name={text:"龙之挑战书",color:"light_purple",italic:false},minecraft:custom_data={kind:"child_boss_quest",id:1},minecraft:enchantment_glint_override=true]
execute if score @s vt_bstage matches 2 run give @s minecraft:paper[minecraft:custom_name={text:"凋灵挑战书",color:"dark_gray",italic:false},minecraft:custom_data={kind:"child_boss_quest",id:2},minecraft:enchantment_glint_override=true]
execute if score @s vt_bstage matches 3 run give @s minecraft:paper[minecraft:custom_name={text:"幽匿挑战书",color:"dark_aqua",italic:false},minecraft:custom_data={kind:"child_boss_quest",id:3},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_cqrep 1
title @s actionbar {"text":"当前挑战书已补领。","color":"green"}
