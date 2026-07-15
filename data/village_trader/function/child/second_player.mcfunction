execute if score @s vt_nvpause matches 1.. run scoreboard players remove @s vt_nvpause 1
execute if score @s vt_child matches 1 if score @s vt_nvpause matches 0 if score @s vt_nvsusp matches 0 run function village_trader:api/night_vision/refresh
execute if score @s vt_child matches 1 run function village_trader:child/effect/auxiliary
execute if score @s vt_child matches 1 run function village_trader:child/effect/equipment
execute if score @s vt_healcd matches 1.. run scoreboard players remove @s vt_healcd 1

