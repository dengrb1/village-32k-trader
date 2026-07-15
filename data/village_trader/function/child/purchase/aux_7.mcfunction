execute if entity @s[tag=village_trader.child_aux_7] run scoreboard players set @s vt_caux 7
execute if entity @s[tag=village_trader.child_aux_7] run title @s actionbar {"text":"已选择龙战护符。","color":"green"}
execute if entity @s[tag=village_trader.child_aux_7] run return 1
execute unless score @s vt_cstage matches 7 run return 0
execute unless score @s vt_bstage matches 1.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:diamond 0
execute unless score @s vt_tmp matches 4.. run title @s actionbar {"text":"需要4钻石和1金苹果。","color":"red"}
execute unless score @s vt_tmp matches 4.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:golden_apple 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"需要4钻石和1金苹果。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
clear @s minecraft:diamond 4
clear @s minecraft:golden_apple 1
give @s minecraft:paper[minecraft:custom_name='{"text":"龙战护符","color":"light_purple","italic":false}',minecraft:custom_data={kind:"child_aux",id:7},minecraft:enchantment_glint_override=true]
tag @s add village_trader.child_aux_7
scoreboard players set @s vt_caux 7
