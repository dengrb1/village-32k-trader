clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:4}] 1
scoreboard players add @s vt_stage 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_d 0
scoreboard players set @s vt_gear 0
give @s minecraft:heart_of_the_sea 1
give @s minecraft:nautilus_shell 8
effect give @s minecraft:water_breathing 1200 0 true
advancement grant @s only village_trader:achievements/story_04
advancement grant @s only village_trader:achievements/explore_03
advancement grant @s only village_trader:achievements/combat_03
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"沧海巡航完成！已获得潮汐补给与 20 分钟水下呼吸。","color":"green","bold":true}]
function village_trader:main/menu/root
