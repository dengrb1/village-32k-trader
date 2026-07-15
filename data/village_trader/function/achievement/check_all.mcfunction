execute unless score @s vt_ach_total matches 40.. run return 0
execute if entity @s[tag=village_trader.achievement_all_claimed] run return 0
tag @s add village_trader.achievement_all_claimed
give @s minecraft:white_banner[minecraft:custom_name={text:"终焉传奇",color:"dark_purple",bold:true,italic:false},minecraft:lore=[{text:"集齐 40 项村庄商人成就的证明",color:"gray",italic:false}],minecraft:custom_data={kind:"achievement_banner",all:true}] 1
title @s actionbar [{"text":"[成就] ","color":"gold"},{"text":"40/40 达成：终焉传奇称号与旗帜已解锁！","color":"light_purple","bold":true}]
