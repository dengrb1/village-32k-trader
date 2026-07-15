advancement revoke @s only village_trader:main/kill_dragon
execute if score @s vt_child matches 0 if score @s vt_stage matches 5 if score @s vt_qactive matches 5 run scoreboard players set @s vt_b 1
execute if score @s vt_child matches 0 if score @s vt_stage matches 10 if score @s vt_qactive matches 10 run scoreboard players set @s vt_b 1
