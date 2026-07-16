advancement revoke @s only village_trader:main/enter_end
execute if score @s vt_child matches 0 if score @s vt_stage matches 5 if score @s vt_qactive matches 5 run scoreboard players set @s vt_a 1
