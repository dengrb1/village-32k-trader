advancement revoke @s only village_trader:child/craft_table
execute if score @s vt_child matches 1 if score @s vt_cstage matches 1 if score @s vt_cactive matches 1 run scoreboard players set @s vt_cb 1

