advancement revoke @s only village_trader:main/kill_warden
execute if score @s vt_child matches 0 if score @s vt_stage matches 9 if score @s vt_qactive matches 9 run scoreboard players set @s vt_a 1
