advancement revoke @s only village_trader:child/eat
execute if score @s vt_child matches 1 if score @s vt_cstage matches 3 if score @s vt_cactive matches 1 run scoreboard players set @s vt_cb 1

