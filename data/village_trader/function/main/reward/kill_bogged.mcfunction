advancement revoke @s only village_trader:main/kill_bogged
execute if score @s vt_child matches 0 if score @s vt_stage matches 7 if score @s vt_qactive matches 7 if score @s vt_c matches ..2 run scoreboard players add @s vt_c 1
