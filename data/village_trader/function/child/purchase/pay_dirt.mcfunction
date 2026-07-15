scoreboard players set @s vt_tmp 4
execute if entity @s[tag=village_trader.child_aux_5] if score @s vt_caux matches 5 if items entity @s inventory.* minecraft:paper[minecraft:custom_data~{kind:"child_aux",id:5}] run scoreboard players set @s vt_tmp 1
execute store result score @s vt_ok run clear @s minecraft:dirt 0
execute unless score @s vt_ok >= @s vt_tmp run title @s actionbar {"text":"泥土不足。普通商品需要4泥土；选中并携带商人徽章时需要1泥土。","color":"red"}
execute unless score @s vt_ok >= @s vt_tmp run return 0
execute if score @s vt_tmp matches 1 run clear @s minecraft:dirt 1
execute if score @s vt_tmp matches 4 run clear @s minecraft:dirt 4
return 1

