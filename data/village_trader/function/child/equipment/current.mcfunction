execute if score @s vt_asc matches 1.. run scoreboard players set @s vt_cgear 128
execute unless score @s vt_asc matches 1.. if score @s vt_cstage matches 1 run scoreboard players set @s vt_cgear 1
execute unless score @s vt_asc matches 1.. if score @s vt_cstage matches 2 run scoreboard players set @s vt_cgear 3
execute unless score @s vt_asc matches 1.. if score @s vt_cstage matches 3 run scoreboard players set @s vt_cgear 5
execute unless score @s vt_asc matches 1.. if score @s vt_cstage matches 4 run scoreboard players set @s vt_cgear 10
execute unless score @s vt_asc matches 1.. if score @s vt_cstage matches 5 run scoreboard players set @s vt_cgear 20
execute unless score @s vt_asc matches 1.. if score @s vt_cstage matches 6..7 run scoreboard players set @s vt_cgear 32
function village_trader:child/equipment/open_pass
