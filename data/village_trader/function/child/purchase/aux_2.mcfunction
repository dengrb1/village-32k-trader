execute if entity @s[tag=village_trader.child_aux_2] run scoreboard players set @s vt_caux 2
execute if entity @s[tag=village_trader.child_aux_2] run title @s actionbar {"text":"已选择矿工护符。","color":"green"}
execute if entity @s[tag=village_trader.child_aux_2] run return 1
execute unless score @s vt_cstage matches 2.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:copper_ingot 0
execute unless score @s vt_tmp matches 4.. run title @s actionbar {"text":"需要4铜锭和2红石。","color":"red"}
execute unless score @s vt_tmp matches 4.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:redstone 0
execute unless score @s vt_tmp matches 2.. run title @s actionbar {"text":"需要4铜锭和2红石。","color":"red"}
execute unless score @s vt_tmp matches 2.. run return 0
clear @s minecraft:copper_ingot 4
clear @s minecraft:redstone 2
give @s minecraft:paper[minecraft:custom_name={text:"矿工护符",color:"aqua",italic:false},minecraft:lore=[{text:"选中并携带：急迫 II、防火",color:"gray",italic:false}],minecraft:custom_data={kind:"child_aux",id:2},minecraft:enchantment_glint_override=true]
tag @s add village_trader.child_aux_2
scoreboard players set @s vt_caux 2
title @s actionbar {"text":"已购买并选择矿工护符。","color":"green"}

