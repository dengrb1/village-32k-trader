execute store result storage village_trader:runtime bossbar.id int 1 run scoreboard players get #cursor vt_barid
function village_trader:bossbar/remove_one with storage village_trader:runtime bossbar
scoreboard players remove #cursor vt_barid 1
execute if score #cursor vt_barid matches 1.. run function village_trader:bossbar/remove_loop
