# 为每名玩家分配一个持久的个人 Boss 栏编号；旧存档会在首次刷新时自动补分配。
execute if score @s vt_barid matches 1.. run return 0
scoreboard players add #next vt_barid 1
scoreboard players operation @s vt_barid = #next vt_barid
execute store result storage village_trader:runtime bossbar.id int 1 run scoreboard players get @s vt_barid
function village_trader:bossbar/create with storage village_trader:runtime bossbar
