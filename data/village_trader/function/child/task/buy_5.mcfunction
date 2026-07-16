execute store result score @s vt_tmp run clear @s minecraft:diamond 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"需要1钻石和4绿宝石。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:emerald 0
execute unless score @s vt_tmp matches 4.. run title @s actionbar {"text":"需要1钻石和4绿宝石。","color":"red"}
execute unless score @s vt_tmp matches 4.. run return 0
clear @s minecraft:diamond 1
clear @s minecraft:emerald 4
give @s minecraft:paper[minecraft:custom_name={text:"商会任务牌",color:"gold",italic:false},minecraft:lore=[{text:"儿童守护线·第五章",color:"gray",italic:false}],minecraft:custom_data={kind:"child_quest",id:5},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_ok 1

