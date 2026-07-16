advancement revoke @s only village_trader:main/kill_piglin
execute if score @s vt_child matches 0 if score @s vt_stage matches 3 if score @s vt_qactive matches 3 if score @s vt_d matches ..4 run scoreboard players add @s vt_d 1
