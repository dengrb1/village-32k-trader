scoreboard players operation @s vt_barvalue = @s vt_ca
scoreboard players operation @s vt_barvalue += @s vt_cb
scoreboard players operation @s vt_barvalue += @s vt_cc
execute store result storage village_trader:runtime bossbar.value int 1 run scoreboard players get @s vt_barvalue
function village_trader:bossbar/child/show_5 with storage village_trader:runtime bossbar
