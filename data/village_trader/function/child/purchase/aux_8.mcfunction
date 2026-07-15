execute if entity @s[tag=village_trader.child_aux_8] run scoreboard players set @s vt_caux 8
execute if entity @s[tag=village_trader.child_aux_8] run title @s actionbar {"text":"已选择净化护符。","color":"green"}
execute if entity @s[tag=village_trader.child_aux_8] run return 1
execute unless score @s vt_cstage matches 7 run return 0
execute unless score @s vt_bstage matches 2.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:emerald_block 0
execute unless score @s vt_tmp matches 2.. run title @s actionbar {"text":"需要2绿宝石块和1牛奶桶。","color":"red"}
execute unless score @s vt_tmp matches 2.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:milk_bucket 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"需要2绿宝石块和1牛奶桶。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
clear @s minecraft:emerald_block 2
clear @s minecraft:milk_bucket 1
give @s minecraft:bucket 1
give @s minecraft:paper[minecraft:custom_name='{"text":"净化护符","color":"white","italic":false}',minecraft:custom_data={kind:"child_aux",id:8},minecraft:enchantment_glint_override=true]
tag @s add village_trader.child_aux_8
scoreboard players set @s vt_caux 8
