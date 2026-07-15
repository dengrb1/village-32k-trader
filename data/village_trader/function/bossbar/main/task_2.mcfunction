scoreboard players operation @s vt_barvalue = @s vt_a
scoreboard players operation @s vt_barvalue += @s vt_b
scoreboard players operation @s vt_barvalue += @s vt_c
execute store result storage village_trader:runtime bossbar.value int 1 run scoreboard players get @s vt_barvalue
function village_trader:bossbar/main/show_2 with storage village_trader:runtime bossbar
