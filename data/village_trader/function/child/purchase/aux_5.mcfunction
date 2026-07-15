execute if entity @s[tag=village_trader.child_aux_5] run scoreboard players set @s vt_caux 5
execute if entity @s[tag=village_trader.child_aux_5] run title @s actionbar {"text":"已选择商人徽章；携带时儿童普通商品降为1泥土。","color":"green"}
execute if entity @s[tag=village_trader.child_aux_5] run return 1
execute unless score @s vt_cstage matches 5.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:emerald 0
execute unless score @s vt_tmp matches 8.. run title @s actionbar {"text":"需要8绿宝石。","color":"red"}
execute unless score @s vt_tmp matches 8.. run return 0
clear @s minecraft:emerald 8
give @s minecraft:paper[minecraft:custom_name='{"text":"商人徽章","color":"green","italic":false}',minecraft:lore=['{"text":"选中并携带：普通商品1泥土、增强任务提示","color":"gray","italic":false}'],minecraft:custom_data={kind:"child_aux",id:5},minecraft:enchantment_glint_override=true]
tag @s add village_trader.child_aux_5
scoreboard players set @s vt_caux 5
title @s actionbar {"text":"已购买并选择商人徽章。","color":"green"}

