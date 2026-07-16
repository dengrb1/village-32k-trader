advancement revoke @s only village_trader:main/craft_beacon
execute if score @s vt_child matches 0 if score @s vt_stage matches 8 if score @s vt_qactive matches 8 run scoreboard players set @s vt_b 1
