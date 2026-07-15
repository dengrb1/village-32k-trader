execute if score @s vt_cqrep matches 1 run title @s actionbar {"text":"守护升格核心的免费补领次数已经用完。","color":"red"}
execute if score @s vt_cqrep matches 1 run return 0
execute store result score @s vt_tmp run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_ascension_core",id:1}] 0
execute if score @s vt_tmp matches 1.. run title @s actionbar {"text":"升格核心仍在背包中。","color":"yellow"}
execute if score @s vt_tmp matches 1.. run return 0
give @s minecraft:paper[minecraft:custom_name='{"text":"守护升格核心","color":"aqua","bold":true,"italic":false}',minecraft:custom_data={kind:"child_ascension_core",id:1},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_cqrep 1
title @s actionbar {"text":"升格核心已补领。","color":"green"}
