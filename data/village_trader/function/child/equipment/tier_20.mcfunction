execute store result score @s vt_ok run function village_trader:child/purchase/pay_dirt
execute unless score @s vt_ok matches 1 run return 0
give @s minecraft:netherite_helmet[minecraft:custom_name='{"text":"20级商会守护盔","color":"dark_aqua","italic":false}',minecraft:enchantments={"minecraft:protection":20,"minecraft:unbreaking":20,"minecraft:respiration":10,"minecraft:aqua_affinity":1},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"head"}]
give @s minecraft:netherite_chestplate[minecraft:enchantments={"minecraft:protection":20,"minecraft:unbreaking":20},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"chest"}]
give @s minecraft:netherite_leggings[minecraft:enchantments={"minecraft:protection":20,"minecraft:unbreaking":20,"minecraft:swift_sneak":3},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"legs"}]
give @s minecraft:netherite_boots[minecraft:enchantments={"minecraft:protection":20,"minecraft:feather_falling":20,"minecraft:unbreaking":20},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"feet"}]
give @s minecraft:netherite_sword[minecraft:enchantments={"minecraft:sharpness":20,"minecraft:looting":10,"minecraft:unbreaking":20},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"weapon"}]
give @s minecraft:netherite_pickaxe[minecraft:enchantments={"minecraft:efficiency":20,"minecraft:fortune":10,"minecraft:unbreaking":20},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"pickaxe"}]
give @s minecraft:netherite_axe[minecraft:enchantments={"minecraft:efficiency":20,"minecraft:unbreaking":20},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"axe"}]
give @s minecraft:netherite_shovel[minecraft:enchantments={"minecraft:efficiency":20,"minecraft:unbreaking":20},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"shovel"}]
give @s minecraft:netherite_hoe[minecraft:enchantments={"minecraft:efficiency":20,"minecraft:unbreaking":20},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"hoe"}]
give @s minecraft:bow[minecraft:enchantments={"minecraft:power":20,"minecraft:punch":5,"minecraft:flame":1,"minecraft:infinity":1,"minecraft:unbreaking":20},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"bow"}]
give @s minecraft:shield[minecraft:enchantments={"minecraft:unbreaking":20},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:20,slot:"shield"}]
title @s actionbar {"text":"已兑换20级下界合金守护套装。","color":"green"}
