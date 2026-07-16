clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:8}] 1
scoreboard players add @s vt_stage 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_d 0
scoreboard players set @s vt_gear 0
give @s minecraft:netherite_ingot 4
give @s minecraft:enchanted_golden_apple 1
give @s minecraft:obsidian 16
advancement grant @s only village_trader:achievements/story_08
advancement grant @s only village_trader:achievements/explore_06
advancement grant @s only village_trader:achievements/combat_07
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"凋灵攻坚完成！已获得终战补给，并解锁 64 级装备。","color":"green","bold":true}]
function village_trader:main/menu/root
