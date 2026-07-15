execute unless entity @s[type=minecraft:player] run return 0
scoreboard players set @s vt_child 0
scoreboard players set @s vt_cstage 1
scoreboard players set @s vt_cqown 0
scoreboard players set @s vt_cqrep 0
scoreboard players set @s vt_cactive 0
scoreboard players set @s vt_ca 0
scoreboard players set @s vt_cb 0
scoreboard players set @s vt_cc 0
scoreboard players set @s vt_bstage 1
scoreboard players set @s vt_bqown 0
scoreboard players set @s vt_bactive 0
scoreboard players set @s vt_asc 0
scoreboard players set @s vt_asckey 0
scoreboard players set @s vt_caux 0
scoreboard players set @s vt_nvpause 0
scoreboard players set @s vt_nvsusp 0
scoreboard players set @s vt_healcd 0
scoreboard players set @s vt_tmp 0
scoreboard players set @s vt_ok 0
scoreboard players set @s vt_action 0
scoreboard players set @s vt_cbcob 0
scoreboard players set @s vt_cbdia 0
scoreboard players set @s vt_cbddia 0
tag @s remove village_trader.child_aux_1
tag @s remove village_trader.child_aux_2
tag @s remove village_trader.child_aux_3
tag @s remove village_trader.child_aux_4
tag @s remove village_trader.child_aux_5
tag @s remove village_trader.child_aux_6
tag @s remove village_trader.child_aux_7
tag @s remove village_trader.child_aux_8
tag @s remove village_trader.child_aux_9
tag @s remove village_trader.mark_dragon
tag @s remove village_trader.mark_wither
tag @s remove village_trader.mark_warden
clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest"}]
clear @s minecraft:paper[minecraft:custom_data~{kind:"child_aux"}]
clear @s minecraft:paper[minecraft:custom_data~{kind:"child_boss_quest"}]
clear @s minecraft:paper[minecraft:custom_data~{kind:"child_ascension_core"}]
tellraw @s [{"text":"[儿童守护线] ","color":"gold"},{"text":"儿童进度、所有权、印记与选择已彻底重置；主线未改动。","color":"red"}]
