execute store result score @s vt_tmp run clear @s minecraft:iron_ingot 0
execute unless score @s vt_tmp matches 3.. run title @s actionbar {"text":"需要3铁锭和8煤炭。","color":"red"}
execute unless score @s vt_tmp matches 3.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:coal 0
execute unless score @s vt_tmp matches 8.. run title @s actionbar {"text":"需要3铁锭和8煤炭。","color":"red"}
execute unless score @s vt_tmp matches 8.. run return 0
clear @s minecraft:iron_ingot 3
clear @s minecraft:coal 8
give @s minecraft:paper[minecraft:custom_name='{"text":"矿工任务牌","color":"gold","italic":false}',minecraft:lore=['{"text":"儿童守护线·第二章","color":"gray","italic":false}'],minecraft:custom_data={kind:"child_quest",id:2},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_ok 1

