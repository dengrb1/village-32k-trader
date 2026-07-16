clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:6}] 1
scoreboard players add @s vt_stage 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_d 0
scoreboard players set @s vt_gear 0
give @s minecraft:totem_of_undying 2
give @s minecraft:emerald 16
give @s minecraft:golden_apple 8
advancement grant @s only village_trader:achievements/story_06
advancement grant @s only village_trader:achievements/combat_05
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"村庄守卫完成！已获得守卫补给，并解锁 32 级装备。","color":"green","bold":true}]
function village_trader:main/menu/root
