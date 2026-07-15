execute store result score @s vt_ok run function village_trader:child/purchase/pay_dirt
execute unless score @s vt_ok matches 1 run return 0
give @s minecraft:diamond_helmet[minecraft:custom_name='{"text":"5级守护钻石盔","color":"aqua","italic":false}',minecraft:enchantments={"minecraft:protection":5,"minecraft:unbreaking":5,"minecraft:respiration":3,"minecraft:aqua_affinity":1},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"head"}]
give @s minecraft:diamond_chestplate[minecraft:enchantments={"minecraft:protection":5,"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"chest"}]
give @s minecraft:diamond_leggings[minecraft:enchantments={"minecraft:protection":5,"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"legs"}]
give @s minecraft:diamond_boots[minecraft:enchantments={"minecraft:protection":5,"minecraft:feather_falling":4,"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"feet"}]
give @s minecraft:diamond_sword[minecraft:enchantments={"minecraft:sharpness":5,"minecraft:looting":3,"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"weapon"}]
give @s minecraft:diamond_pickaxe[minecraft:enchantments={"minecraft:efficiency":5,"minecraft:fortune":3,"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"pickaxe"}]
give @s minecraft:diamond_axe[minecraft:enchantments={"minecraft:efficiency":5,"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"axe"}]
give @s minecraft:diamond_shovel[minecraft:enchantments={"minecraft:efficiency":5,"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"shovel"}]
give @s minecraft:diamond_hoe[minecraft:enchantments={"minecraft:efficiency":5,"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"hoe"}]
give @s minecraft:bow[minecraft:enchantments={"minecraft:power":5,"minecraft:punch":2,"minecraft:flame":1,"minecraft:infinity":1,"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"bow"}]
give @s minecraft:shield[minecraft:enchantments={"minecraft:unbreaking":5},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:5,slot:"shield"}]
title @s actionbar {"text":"已兑换5级钻石守护套装。","color":"green"}
