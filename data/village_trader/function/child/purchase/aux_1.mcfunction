execute if entity @s[tag=village_trader.child_aux_1] run scoreboard players set @s vt_caux 1
execute if entity @s[tag=village_trader.child_aux_1] run title @s actionbar {"text":"已选择伐木手套。","color":"green"}
execute if entity @s[tag=village_trader.child_aux_1] run return 1
execute unless score @s vt_cstage matches 1.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:leather 0
execute unless score @s vt_tmp matches 2.. run title @s actionbar {"text":"需要2皮革和2铁锭。","color":"red"}
execute unless score @s vt_tmp matches 2.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:iron_ingot 0
execute unless score @s vt_tmp matches 2.. run title @s actionbar {"text":"需要2皮革和2铁锭。","color":"red"}
execute unless score @s vt_tmp matches 2.. run return 0
clear @s minecraft:leather 2
clear @s minecraft:iron_ingot 2
give @s minecraft:paper[minecraft:custom_name='{"text":"伐木手套","color":"gold","italic":false}',minecraft:lore=['{"text":"选中并携带：急迫 I","color":"gray","italic":false}'],minecraft:custom_data={kind:"child_aux",id:1},minecraft:enchantment_glint_override=true]
tag @s add village_trader.child_aux_1
scoreboard players set @s vt_caux 1
title @s actionbar {"text":"已购买并选择伐木手套。","color":"green"}

