clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:1}] 1
scoreboard players add @s vt_stage 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_d 0
scoreboard players set @s vt_gear 0
give @s minecraft:bread 24
give @s minecraft:torch 48
advancement grant @s only village_trader:achievements/story_01
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"定居启程完成！已获得行旅补给，并解锁 5 级装备。","color":"green","bold":true}]
function village_trader:main/menu/root
