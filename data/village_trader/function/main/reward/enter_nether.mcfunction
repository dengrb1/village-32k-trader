advancement revoke @s only village_trader:main/enter_nether
execute if score @s vt_child matches 0 if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players set @s vt_a 1

