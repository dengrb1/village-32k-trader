clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:7}] 1
scoreboard players add @s vt_stage 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_gear 0
give @s minecraft:trial_key 4
give @s minecraft:wind_charge 16
give @s minecraft:golden_apple 8
advancement grant @s only village_trader:achievements/story_07
advancement grant @s only village_trader:achievements/explore_05
advancement grant @s only village_trader:achievements/combat_06
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"试炼密室完成！已获得试炼补给。","color":"green","bold":true}]
function village_trader:main/menu/root
