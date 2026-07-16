advancement revoke @s only village_trader:main/craft_conduit
execute if score @s vt_child matches 0 if score @s vt_stage matches 4 if score @s vt_qactive matches 4 run scoreboard players set @s vt_b 1
