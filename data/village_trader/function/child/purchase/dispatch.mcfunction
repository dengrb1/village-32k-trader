execute unless score @s vt_child matches 1 run return 0
scoreboard players set @s vt_ok 0
execute if score @s vt_action matches 301..302 if score @s vt_cstage matches 1.. run scoreboard players set @s vt_ok 1
execute if score @s vt_action matches 303 if score @s vt_cstage matches 2.. run scoreboard players set @s vt_ok 1
execute if score @s vt_action matches 304..305 if score @s vt_cstage matches 3.. run scoreboard players set @s vt_ok 1
execute if score @s vt_action matches 306..307 if score @s vt_cstage matches 4.. run scoreboard players set @s vt_ok 1
execute if score @s vt_action matches 308..310 if score @s vt_cstage matches 5.. run scoreboard players set @s vt_ok 1
execute if score @s vt_action matches 311..312 if score @s vt_cstage matches 6.. run scoreboard players set @s vt_ok 1
execute unless score @s vt_ok matches 1 run title @s actionbar {"text":"该商品尚未解锁。","color":"red"}
execute unless score @s vt_ok matches 1 run return 0
execute store result score @s vt_ok run function village_trader:child/purchase/pay_dirt
execute unless score @s vt_ok matches 1 run return 0
execute if score @s vt_action matches 301 run give @s minecraft:bread 8
execute if score @s vt_action matches 302 run give @s minecraft:torch 16
execute if score @s vt_action matches 303 run give @s minecraft:emerald 4
execute if score @s vt_action matches 304 run give @s minecraft:diamond 1
execute if score @s vt_action matches 305 run give @s minecraft:golden_apple 1
execute if score @s vt_action matches 306 run give @s minecraft:diamond_block 1
execute if score @s vt_action matches 307 run give @s minecraft:emerald_block 1
execute if score @s vt_action matches 308 run give @s minecraft:netherite_scrap 1
execute if score @s vt_action matches 309 run give @s minecraft:netherite_ingot 1
execute if score @s vt_action matches 310 run give @s minecraft:totem_of_undying 1
execute if score @s vt_action matches 311 run give @s minecraft:netherite_block 1
execute if score @s vt_action matches 312 run give @s minecraft:enchanted_golden_apple 1
execute if score @s vt_cstage matches 5 if score @s vt_cactive matches 1 run scoreboard players set @s vt_ca 1
title @s actionbar {"text":"兑换成功。","color":"green"}
