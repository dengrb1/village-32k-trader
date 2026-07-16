execute if score @s vt_action matches 190 run function village_trader:main/purchase/buy_selected
execute if score @s vt_action matches 191 run scoreboard players set @s vt_buy_pending 1
execute if score @s vt_action matches 191 run function village_trader:main/purchase/buy_selected
execute if score @s vt_action matches 192 run scoreboard players set @s vt_buy_pending 16
execute if score @s vt_action matches 192 run function village_trader:main/purchase/buy_selected
execute if score @s vt_action matches 193 run scoreboard players set @s vt_buy_pending 64
execute if score @s vt_action matches 193 run function village_trader:main/purchase/buy_selected
