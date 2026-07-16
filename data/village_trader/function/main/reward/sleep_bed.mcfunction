advancement revoke @s only village_trader:main/sleep_bed
execute if score @s vt_child matches 0 if score @s vt_stage matches 1 if score @s vt_qactive matches 1 run scoreboard players set @s vt_b 1
