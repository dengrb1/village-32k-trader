advancement revoke @s only village_trader:child/kill_training_mob
execute if score @s vt_child matches 1 if score @s vt_cstage matches 4 if score @s vt_cactive matches 1 run scoreboard players add @s vt_cb 1
execute if score @s vt_cb matches 4.. run scoreboard players set @s vt_cb 3

