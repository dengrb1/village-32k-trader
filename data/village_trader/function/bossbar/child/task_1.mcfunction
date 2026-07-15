scoreboard players operation @s vt_barvalue = @s vt_ca
scoreboard players operation @s vt_barvalue += @s vt_cb
execute store result storage village_trader:runtime bossbar.value int 1 run scoreboard players get @s vt_barvalue
function village_trader:bossbar/child/show_1 with storage village_trader:runtime bossbar
