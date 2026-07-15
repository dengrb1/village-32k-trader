clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:4}] 1
scoreboard players add @s vt_stage 1
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_gear 0
tellraw @s [{"text":"[村庄商人] 「村庄守卫令」已提交并消耗，个人主线晋升至阶段 5！","color":"green","bold":true}]
function village_trader:main/menu/root

