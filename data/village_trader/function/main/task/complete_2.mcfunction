clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:2}] 1
scoreboard players add @s vt_stage 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_d 0
scoreboard players set @s vt_gear 0
give @s minecraft:diamond 8
give @s minecraft:iron_ingot 16
give @s minecraft:coal 32
advancement grant @s only village_trader:achievements/story_02
advancement grant @s only village_trader:achievements/explore_01
advancement grant @s only village_trader:achievements/combat_01
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"矿脉勘探完成！已获得采掘补给，并解锁 10 级装备。","color":"green","bold":true}]
function village_trader:main/menu/root
