scoreboard players operation @s vt_barvalue = @s vt_a
execute store result storage village_trader:runtime bossbar.value int 1 run scoreboard players get @s vt_barvalue
function village_trader:bossbar/main/show_6 with storage village_trader:runtime bossbar
