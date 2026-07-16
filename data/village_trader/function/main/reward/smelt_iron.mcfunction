advancement revoke @s only village_trader:main/smelt_iron
execute if score @s vt_child matches 0 if score @s vt_stage matches 1 if score @s vt_qactive matches 1 if score @s vt_c matches ..7 run scoreboard players add @s vt_c 1
