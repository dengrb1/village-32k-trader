execute store result score @s vt_tmp run clear @s #minecraft:logs 0
execute unless score @s vt_tmp matches 4.. run title @s actionbar {"text":"需要4个任意原木。","color":"red"}
execute unless score @s vt_tmp matches 4.. run return 0
clear @s #minecraft:logs 4
give @s minecraft:paper[minecraft:custom_name={text:"木工任务牌",color:"gold",italic:false},minecraft:lore=[{text:"儿童守护线·第一章",color:"gray",italic:false}],minecraft:custom_data={kind:"child_quest",id:1},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_ok 1

