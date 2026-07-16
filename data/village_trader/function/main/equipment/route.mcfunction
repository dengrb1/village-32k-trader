execute if score @s vt_action matches 150 run function village_trader:main/equipment/current
execute if score @s vt_action matches 151 run function village_trader:main/equipment/select_5
execute if score @s vt_action matches 152 run function village_trader:main/equipment/select_10
execute if score @s vt_action matches 153 run function village_trader:main/equipment/select_20
execute if score @s vt_action matches 154 run function village_trader:main/equipment/select_32
execute if score @s vt_action matches 155 run function village_trader:main/equipment/select_64
execute if score @s vt_action matches 157 run function village_trader:main/equipment/select_255
execute if score @s vt_action matches 500 run scoreboard players set @s vt_ui 17
execute if score @s vt_action matches 501 run scoreboard players set @s vt_ui 18
execute if score @s vt_action matches 502 run scoreboard players set @s vt_ui 19
execute if score @s vt_action matches 503 run scoreboard players set @s vt_ui 20
execute if score @s vt_action matches 500..503 run function village_trader:ui/open_current
execute if score @s vt_action matches 510 run scoreboard players set @s vt_equip_slot 1
execute if score @s vt_action matches 511 run scoreboard players set @s vt_equip_slot 2
execute if score @s vt_action matches 512 run scoreboard players set @s vt_equip_slot 3
execute if score @s vt_action matches 513 run scoreboard players set @s vt_equip_slot 4
execute if score @s vt_action matches 520 run scoreboard players set @s vt_equip_slot 5
execute if score @s vt_action matches 521 run scoreboard players set @s vt_equip_slot 6
execute if score @s vt_action matches 522 run scoreboard players set @s vt_equip_slot 15
execute if score @s vt_action matches 523 run scoreboard players set @s vt_equip_slot 16
execute if score @s vt_action matches 524 run scoreboard players set @s vt_equip_slot 17
execute if score @s vt_action matches 530 run scoreboard players set @s vt_equip_slot 7
execute if score @s vt_action matches 531 run scoreboard players set @s vt_equip_slot 8
execute if score @s vt_action matches 532 run scoreboard players set @s vt_equip_slot 9
execute if score @s vt_action matches 533 run scoreboard players set @s vt_equip_slot 10
execute if score @s vt_action matches 540 run scoreboard players set @s vt_equip_slot 11
execute if score @s vt_action matches 541 run scoreboard players set @s vt_equip_slot 12
execute if score @s vt_action matches 550 run scoreboard players set @s vt_equip_slot 13
execute if score @s vt_action matches 551 run scoreboard players set @s vt_equip_slot 14
execute if score @s vt_action matches 510..513 run function village_trader:main/equipment/claim
execute if score @s vt_action matches 520..524 run function village_trader:main/equipment/claim
execute if score @s vt_action matches 530..533 run function village_trader:main/equipment/claim
execute if score @s vt_action matches 540..541 run function village_trader:main/equipment/claim
execute if score @s vt_action matches 550..551 run function village_trader:main/equipment/claim
