execute if entity @s[tag=village_trader.child_aux_3] run scoreboard players set @s vt_caux 3
execute if entity @s[tag=village_trader.child_aux_3] run title @s actionbar {"text":"已选择旅行护符。","color":"green"}
execute if entity @s[tag=village_trader.child_aux_3] run return 1
execute unless score @s vt_cstage matches 3.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:compass 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"需要1指南针和4面包。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:bread 0
execute unless score @s vt_tmp matches 4.. run title @s actionbar {"text":"需要1指南针和4面包。","color":"red"}
execute unless score @s vt_tmp matches 4.. run return 0
clear @s minecraft:compass 1
clear @s minecraft:bread 4
give @s minecraft:paper[minecraft:custom_name={text:"旅行护符",color:"green",italic:false},minecraft:lore=[{text:"选中并携带：速度 I、缓降",color:"gray",italic:false}],minecraft:custom_data={kind:"child_aux",id:3},minecraft:enchantment_glint_override=true]
tag @s add village_trader.child_aux_3
scoreboard players set @s vt_caux 3
title @s actionbar {"text":"已购买并选择旅行护符。","color":"green"}

