advancement revoke @s only village_trader:child/place_torch
execute if score @s vt_child matches 1 if score @s vt_cstage matches 3 if score @s vt_cactive matches 1 run scoreboard players add @s vt_ca 1
execute if score @s vt_ca matches 9.. run scoreboard players set @s vt_ca 8

