clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:5}] 1
scoreboard players add @s vt_stage 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_gear 0
give @s minecraft:ender_pearl 16
effect give @s minecraft:slow_falling 1200 0 true
advancement grant @s only village_trader:achievements/story_05
advancement grant @s only village_trader:achievements/explore_04
advancement grant @s only village_trader:achievements/combat_04
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"末地远征完成！已获得末影补给、缓降，并解锁 20 级装备。","color":"green","bold":true}]
function village_trader:main/menu/root
