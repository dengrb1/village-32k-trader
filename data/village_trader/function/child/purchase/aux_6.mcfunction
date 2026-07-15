execute if entity @s[tag=village_trader.child_aux_6] run scoreboard players set @s vt_caux 6
execute if entity @s[tag=village_trader.child_aux_6] run title @s actionbar {"text":"已选择守护护符。","color":"green"}
execute if entity @s[tag=village_trader.child_aux_6] run return 1
execute unless score @s vt_cstage matches 6.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:diamond 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"需要1钻石和1不死图腾。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:totem_of_undying 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"需要1钻石和1不死图腾。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
clear @s minecraft:diamond 1
clear @s minecraft:totem_of_undying 1
give @s minecraft:paper[minecraft:custom_name='{"text":"守护护符","color":"light_purple","italic":false}',minecraft:lore=['{"text":"选中并携带：抗性 II、再生 II、防火、缓降","color":"gray","italic":false}'],minecraft:custom_data={kind:"child_aux",id:6},minecraft:enchantment_glint_override=true]
tag @s add village_trader.child_aux_6
scoreboard players set @s vt_caux 6
title @s actionbar {"text":"已购买并选择守护护符。","color":"green"}

