# 只读计算辅助用品状态；状态码变化时才提示，避免每秒刷屏。
scoreboard players set @s vt_aux_reg 0
scoreboard players set @s vt_aux_carried 0
scoreboard players set @s vt_tmp 0
execute if score @s vt_aux matches 1 if entity @s[tag=village_trader.main_aux_1] run scoreboard players set @s vt_aux_reg 1
execute if score @s vt_aux matches 2 if entity @s[tag=village_trader.main_aux_2] run scoreboard players set @s vt_aux_reg 1
execute if score @s vt_aux matches 3 if entity @s[tag=village_trader.main_aux_3] run scoreboard players set @s vt_aux_reg 1
execute if score @s vt_aux matches 4 if entity @s[tag=village_trader.main_aux_4] run scoreboard players set @s vt_aux_reg 1
execute if score @s vt_aux matches 5 if entity @s[tag=village_trader.main_aux_5] run scoreboard players set @s vt_aux_reg 1
execute if score @s vt_aux matches 6 if entity @s[tag=village_trader.main_aux_6] run scoreboard players set @s vt_aux_reg 1
execute if score @s vt_aux matches 7 if entity @s[tag=village_trader.main_aux_7] run scoreboard players set @s vt_aux_reg 1
execute if score @s vt_aux matches 8 if entity @s[tag=village_trader.main_aux_8] run scoreboard players set @s vt_aux_reg 1
execute if score @s vt_aux matches 1 store result score @s vt_aux_carried run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:1}] 0
execute if score @s vt_aux matches 2 store result score @s vt_aux_carried run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:2}] 0
execute if score @s vt_aux matches 3 store result score @s vt_aux_carried run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:3}] 0
execute if score @s vt_aux matches 4 store result score @s vt_aux_carried run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:4}] 0
execute if score @s vt_aux matches 5 store result score @s vt_aux_carried run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:5}] 0
execute if score @s vt_aux matches 6 store result score @s vt_aux_carried run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:6}] 0
execute if score @s vt_aux matches 7 store result score @s vt_aux_carried run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:7}] 0
execute if score @s vt_aux matches 8 store result score @s vt_aux_carried run clear @s minecraft:paper[minecraft:custom_data~{kind:"main_aid",id:8}] 0
execute if score @s vt_aux_carried matches 1.. run scoreboard players set @s vt_aux_carried 1
execute if score @s vt_aux_carried matches 1.. if score @s vt_aux_reg matches 1 run scoreboard players operation @s vt_tmp = @s vt_aux
execute if score @s vt_tmp matches 2 unless dimension minecraft:the_nether run scoreboard players set @s vt_tmp 0
execute if score @s vt_tmp matches 3 unless dimension minecraft:the_end run scoreboard players set @s vt_tmp 0
execute if score @s vt_tmp matches 6 unless predicate village_trader:main/in_deep_dark run scoreboard players set @s vt_tmp 0
execute if score @s vt_tmp matches 7 unless dimension minecraft:overworld run scoreboard players set @s vt_tmp 0
execute if score @s vt_tmp matches 4 run function village_trader:main/effect/auxiliary_state_raid
execute unless score @s vt_tmp = @s vt_aux_state run function village_trader:main/effect/auxiliary_state_changed
scoreboard players operation @s vt_aux_state = @s vt_tmp
