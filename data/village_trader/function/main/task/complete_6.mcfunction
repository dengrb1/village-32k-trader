clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:6}] 1
scoreboard players set @s vt_qactive 7
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_gear 0
tellraw @s [{"text":"[村庄商人] 深暗挑战完成！255 级 32K 终焉主宰装备已永久解锁。","color":"dark_purple","bold":true}]
function village_trader:main/menu/root

