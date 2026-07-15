execute store result score @s vt_tmp run clear @s minecraft:echo_shard 0
execute unless score @s vt_tmp matches 8.. run title @s actionbar {"text":"幽匿挑战书需要8回响碎片、16羊毛和1图腾。","color":"red"}
execute unless score @s vt_tmp matches 8.. run return 0
execute store result score @s vt_tmp run clear @s #minecraft:wool 0
execute unless score @s vt_tmp matches 16.. run title @s actionbar {"text":"幽匿挑战书需要8回响碎片、16羊毛和1图腾。","color":"red"}
execute unless score @s vt_tmp matches 16.. run return 0
execute store result score @s vt_tmp run clear @s minecraft:totem_of_undying 0
execute unless score @s vt_tmp matches 1.. run title @s actionbar {"text":"幽匿挑战书需要8回响碎片、16羊毛和1图腾。","color":"red"}
execute unless score @s vt_tmp matches 1.. run return 0
clear @s minecraft:echo_shard 8
clear @s #minecraft:wool 16
clear @s minecraft:totem_of_undying 1
give @s minecraft:paper[minecraft:custom_name='{"text":"幽匿挑战书","color":"dark_aqua","italic":false}',minecraft:custom_data={kind:"child_boss_quest",id:3},minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_ok 1

