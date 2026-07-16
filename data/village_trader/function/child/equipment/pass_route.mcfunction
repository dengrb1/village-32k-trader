execute if score @s vt_action matches 400 run scoreboard players set @s vt_ui 32
execute if score @s vt_action matches 401 run scoreboard players set @s vt_ui 33
execute if score @s vt_action matches 402 run scoreboard players set @s vt_ui 34
execute if score @s vt_action matches 403 run scoreboard players set @s vt_ui 35
execute if score @s vt_action matches 404 run scoreboard players set @s vt_ui 31
execute if score @s vt_action matches 400..404 run function village_trader:ui/open_current
execute if score @s vt_action matches 410 run scoreboard players set @s vt_cequip_slot 1
execute if score @s vt_action matches 411 run scoreboard players set @s vt_cequip_slot 2
execute if score @s vt_action matches 412 run scoreboard players set @s vt_cequip_slot 3
execute if score @s vt_action matches 413 run scoreboard players set @s vt_cequip_slot 4
execute if score @s vt_action matches 420 run scoreboard players set @s vt_cequip_slot 5
execute if score @s vt_action matches 421 run scoreboard players set @s vt_cequip_slot 6
execute if score @s vt_action matches 422 run scoreboard players set @s vt_cequip_slot 8
execute if score @s vt_action matches 430 run scoreboard players set @s vt_cequip_slot 7
execute if score @s vt_action matches 431 run scoreboard players set @s vt_cequip_slot 9
execute if score @s vt_action matches 432 run scoreboard players set @s vt_cequip_slot 10
execute if score @s vt_action matches 440 run scoreboard players set @s vt_cequip_slot 11
execute if score @s vt_action matches 441 run scoreboard players set @s vt_cequip_slot 12
execute if score @s vt_action matches 410..413 run function village_trader:child/equipment/claim
execute if score @s vt_action matches 420..422 run function village_trader:child/equipment/claim
execute if score @s vt_action matches 430..432 run function village_trader:child/equipment/claim
execute if score @s vt_action matches 440..441 run function village_trader:child/equipment/claim
