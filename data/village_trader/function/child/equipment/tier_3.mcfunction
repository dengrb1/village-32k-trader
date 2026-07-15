execute store result score @s vt_ok run function village_trader:child/purchase/pay_dirt
execute unless score @s vt_ok matches 1 run return 0
give @s minecraft:iron_helmet[minecraft:custom_name='{"text":"3级守护铁盔","color":"green","italic":false}',minecraft:enchantments={"minecraft:protection":3,"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"head"}]
give @s minecraft:iron_chestplate[minecraft:custom_name='{"text":"3级守护铁甲","color":"green","italic":false}',minecraft:enchantments={"minecraft:protection":3,"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"chest"}]
give @s minecraft:iron_leggings[minecraft:custom_name='{"text":"3级守护护腿","color":"green","italic":false}',minecraft:enchantments={"minecraft:protection":3,"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"legs"}]
give @s minecraft:iron_boots[minecraft:custom_name='{"text":"3级守护铁靴","color":"green","italic":false}',minecraft:enchantments={"minecraft:protection":3,"minecraft:feather_falling":3,"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"feet"}]
give @s minecraft:iron_sword[minecraft:enchantments={"minecraft:sharpness":3,"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"weapon"}]
give @s minecraft:iron_pickaxe[minecraft:enchantments={"minecraft:efficiency":3,"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"pickaxe"}]
give @s minecraft:iron_axe[minecraft:enchantments={"minecraft:efficiency":3,"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"axe"}]
give @s minecraft:iron_shovel[minecraft:enchantments={"minecraft:efficiency":3,"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"shovel"}]
give @s minecraft:iron_hoe[minecraft:enchantments={"minecraft:efficiency":3,"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"hoe"}]
give @s minecraft:bow[minecraft:enchantments={"minecraft:power":3,"minecraft:unbreaking":3,"minecraft:infinity":1},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"bow"}]
give @s minecraft:shield[minecraft:enchantments={"minecraft:unbreaking":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:3,slot:"shield"}]
title @s actionbar {"text":"已兑换3级铁质守护套装。","color":"green"}
