execute store result score @s vt_tmp run clear @s minecraft:coal 0
execute unless score @s vt_tmp matches 8.. run title @s actionbar {"text":"需要8煤炭和8小麦。","color":"red"}
execute unless score @s vt_tmp matches 8.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:wheat 0
execute unless score @s vt_tmp matches 8.. run title @s actionbar {"text":"需要8煤炭和8小麦。","color":"red"}
execute unless score @s vt_tmp matches 8.. run return 0
clear @s minecraft:coal 8
clear @s minecraft:wheat 8
give @s minecraft:paper[minecraft:custom_name={text:"旅途任务牌",color:"gold",italic:false},minecraft:lore=[{text:"儿童守护线·第三章",color:"gray",italic:false}],minecraft:custom_data={kind:"child_quest",id:3},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_ok 1

