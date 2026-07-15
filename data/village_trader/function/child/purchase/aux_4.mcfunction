execute if entity @s[tag=village_trader.child_aux_4] run scoreboard players set @s vt_caux 4
execute if entity @s[tag=village_trader.child_aux_4] run title @s actionbar {"text":"已选择勇气护符。","color":"green"}
execute if entity @s[tag=village_trader.child_aux_4] run return 1
execute unless score @s vt_cstage matches 4.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:gold_ingot 0
execute unless score @s vt_tmp matches 4.. run title @s actionbar {"text":"需要4金锭和1金苹果。","color":"red"}
execute unless score @s vt_tmp matches 4.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:golden_apple 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"需要4金锭和1金苹果。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
clear @s minecraft:gold_ingot 4
clear @s minecraft:golden_apple 1
give @s minecraft:paper[minecraft:custom_name={text:"勇气护符",color:"red",italic:false},minecraft:lore=[{text:"选中并携带：抗性 I、再生 I",color:"gray",italic:false}],minecraft:custom_data={kind:"child_aux",id:4},minecraft:enchantment_glint_override=true]
tag @s add village_trader.child_aux_4
scoreboard players set @s vt_caux 4
title @s actionbar {"text":"已购买并选择勇气护符。","color":"green"}

