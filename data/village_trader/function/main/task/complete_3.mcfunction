clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:3}] 1
scoreboard players add @s vt_stage 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_gear 0
give @s minecraft:obsidian 8
effect give @s minecraft:fire_resistance 1200 0 true
advancement grant @s only village_trader:achievements/story_03
advancement grant @s only village_trader:achievements/explore_02
advancement grant @s only village_trader:achievements/combat_02
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"下界远征完成！已获得黑曜石与 20 分钟抗火补给。","color":"green","bold":true}]
function village_trader:main/menu/root
