execute store result score @s vt_tmp run clear @s minecraft:diamond 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"需要1钻石、8金锭和1金苹果。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:gold_ingot 0
execute unless score @s vt_tmp matches 8.. run title @s actionbar {"text":"需要1钻石、8金锭和1金苹果。","color":"red"}
execute unless score @s vt_tmp matches 8.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:golden_apple 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"需要1钻石、8金锭和1金苹果。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
clear @s minecraft:diamond 1
clear @s minecraft:gold_ingot 8
clear @s minecraft:golden_apple 1
give @s minecraft:paper[minecraft:custom_name={text:"守护任务牌",color:"gold",italic:false},minecraft:lore=[{text:"儿童守护线·第六章",color:"gray",italic:false}],minecraft:custom_data={kind:"child_quest",id:6},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_ok 1

