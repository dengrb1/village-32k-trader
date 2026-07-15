execute store result score @s vt_tmp run clear @s minecraft:rotten_flesh 0
execute unless score @s vt_tmp matches 3.. run title @s actionbar {"text":"需要3腐肉和3骨头。","color":"red"}
execute unless score @s vt_tmp matches 3.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:bone 0
execute unless score @s vt_tmp matches 3.. run title @s actionbar {"text":"需要3腐肉和3骨头。","color":"red"}
execute unless score @s vt_tmp matches 3.. run return 0
clear @s minecraft:rotten_flesh 3
clear @s minecraft:bone 3
give @s minecraft:paper[minecraft:custom_name='{"text":"勇气任务牌","color":"gold","italic":false}',minecraft:lore=['{"text":"儿童守护线·第四章","color":"gray","italic":false}'],minecraft:custom_data={kind:"child_quest",id:4},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_ok 1

