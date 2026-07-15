execute store result score @s vt_ok run function village_trader:child/purchase/pay_dirt
execute unless score @s vt_ok matches 1 run return 0
give @s minecraft:diamond_helmet[minecraft:custom_name='{"text":"10级勇气钻石盔","color":"blue","italic":false}',minecraft:enchantments={"minecraft:protection":10,"minecraft:unbreaking":10,"minecraft:respiration":5,"minecraft:aqua_affinity":1},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"head"}]
give @s minecraft:diamond_chestplate[minecraft:enchantments={"minecraft:protection":10,"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"chest"}]
give @s minecraft:diamond_leggings[minecraft:enchantments={"minecraft:protection":10,"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"legs"}]
give @s minecraft:diamond_boots[minecraft:enchantments={"minecraft:protection":10,"minecraft:feather_falling":10,"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"feet"}]
give @s minecraft:diamond_sword[minecraft:enchantments={"minecraft:sharpness":10,"minecraft:looting":5,"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"weapon"}]
give @s minecraft:diamond_pickaxe[minecraft:enchantments={"minecraft:efficiency":10,"minecraft:fortune":5,"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"pickaxe"}]
give @s minecraft:diamond_axe[minecraft:enchantments={"minecraft:efficiency":10,"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"axe"}]
give @s minecraft:diamond_shovel[minecraft:enchantments={"minecraft:efficiency":10,"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"shovel"}]
give @s minecraft:diamond_hoe[minecraft:enchantments={"minecraft:efficiency":10,"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"hoe"}]
give @s minecraft:bow[minecraft:enchantments={"minecraft:power":10,"minecraft:punch":3,"minecraft:flame":1,"minecraft:infinity":1,"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"bow"}]
give @s minecraft:shield[minecraft:enchantments={"minecraft:unbreaking":10},minecraft:unbreakable={},minecraft:custom_data={kind:"child_equipment",tier:10,slot:"shield"}]
title @s actionbar {"text":"已兑换10级钻石守护套装。","color":"green"}
