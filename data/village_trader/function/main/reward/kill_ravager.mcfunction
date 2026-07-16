advancement revoke @s only village_trader:main/kill_ravager
execute if score @s vt_child matches 0 if score @s vt_stage matches 6 if score @s vt_qactive matches 6 run scoreboard players set @s vt_c 1
