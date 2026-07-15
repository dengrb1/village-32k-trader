execute if entity @s[tag=village_trader.child_aux_9] run scoreboard players set @s vt_caux 9
execute if entity @s[tag=village_trader.child_aux_9] run title @s actionbar {"text":"已选择深暗护符。","color":"green"}
execute if entity @s[tag=village_trader.child_aux_9] run return 1
execute unless score @s vt_cstage matches 7 run return 0
execute unless score @s vt_bstage matches 3.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:echo_shard 0
execute unless score @s vt_tmp matches 4.. run title @s actionbar {"text":"需要4回响碎片和8羊毛。","color":"red"}
execute unless score @s vt_tmp matches 4.. run return 0
execute store result score @s vt_tmp run clear @s #minecraft:wool 0
execute unless score @s vt_tmp matches 8.. run title @s actionbar {"text":"需要4回响碎片和8羊毛。","color":"red"}
execute unless score @s vt_tmp matches 8.. run return 0
clear @s minecraft:echo_shard 4
clear @s #minecraft:wool 8
give @s minecraft:paper[minecraft:custom_name='{"text":"深暗护符","color":"dark_aqua","italic":false}',minecraft:custom_data={kind:"child_aux",id:9},minecraft:enchantment_glint_override=true]
tag @s add village_trader.child_aux_9
scoreboard players set @s vt_caux 9
