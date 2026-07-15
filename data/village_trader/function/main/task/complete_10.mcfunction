clear @s minecraft:paper[minecraft:custom_data~{kind:"main_quest",id:10}] 1
scoreboard players set @s vt_stage 11
scoreboard players set @s vt_qactive 11
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_gear 0
give @s minecraft:firework_rocket 64
give @s minecraft:enchanted_golden_apple 2
give @s minecraft:white_banner[minecraft:custom_name={text:"终焉传奇旗帜",color:"dark_purple",bold:true,italic:false},minecraft:lore=[{text:"完成十章主线的证明",color:"gray",italic:false}],minecraft:custom_data={kind:"main_final_banner"}] 1
advancement grant @s only village_trader:achievements/story_10
advancement grant @s only village_trader:achievements/explore_08
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"龙魂再临完成！255 级终焉主宰装备现已永久解锁。","color":"dark_purple","bold":true}]
function village_trader:main/menu/root
