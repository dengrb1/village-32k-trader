scoreboard players operation @s vt_barvalue = @s vt_a
scoreboard players operation @s vt_barvalue += @s vt_b
execute store result storage village_trader:runtime bossbar.value int 1 run scoreboard players get @s vt_barvalue
function village_trader:bossbar/main/show_1 with storage village_trader:runtime bossbar
