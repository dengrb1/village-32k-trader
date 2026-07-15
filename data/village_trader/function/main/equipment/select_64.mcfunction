execute unless score @s vt_stage matches 6 run return 0
execute if score @s vt_diff matches 1 unless score @s vt_qactive matches 7 run return 0
scoreboard players set @s vt_gear 5
function village_trader:main/menu/equipment
