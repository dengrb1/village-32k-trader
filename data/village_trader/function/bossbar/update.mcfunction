# 每秒刷新一次个人任务栏。动态编号让不同玩家拥有完全独立的标题、数值和颜色。
execute unless score @s vt_barid matches 1.. run function village_trader:bossbar/allocate
execute store result storage village_trader:runtime bossbar.id int 1 run scoreboard players get @s vt_barid
function village_trader:bossbar/prepare with storage village_trader:runtime bossbar

execute if score @s vt_child matches 0 run function village_trader:bossbar/main/idle with storage village_trader:runtime bossbar
execute if score @s vt_child matches 0 if score @s vt_qactive matches 1 if score @s vt_stage matches 1 run function village_trader:bossbar/main/task_1
execute if score @s vt_child matches 0 if score @s vt_qactive matches 2 if score @s vt_stage matches 2 run function village_trader:bossbar/main/task_2
execute if score @s vt_child matches 0 if score @s vt_qactive matches 3 if score @s vt_stage matches 3 run function village_trader:bossbar/main/task_3
execute if score @s vt_child matches 0 if score @s vt_qactive matches 4 if score @s vt_stage matches 4 run function village_trader:bossbar/main/task_4
execute if score @s vt_child matches 0 if score @s vt_qactive matches 5 if score @s vt_stage matches 5 run function village_trader:bossbar/main/task_5
execute if score @s vt_child matches 0 if score @s vt_qactive matches 6 if score @s vt_stage matches 6 run function village_trader:bossbar/main/task_6

execute if score @s vt_child matches 1 if score @s vt_cstage matches 1..6 run function village_trader:bossbar/child/idle with storage village_trader:runtime bossbar
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 1 run function village_trader:bossbar/child/task_1
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 2 run function village_trader:bossbar/child/task_2
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 3 run function village_trader:bossbar/child/task_3
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 4 run function village_trader:bossbar/child/task_4
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 run function village_trader:bossbar/child/task_5
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 6 run function village_trader:bossbar/child/task_6

execute if score @s vt_child matches 1 if score @s vt_cstage matches 7 if score @s vt_bstage matches 1..3 run function village_trader:bossbar/boss/idle with storage village_trader:runtime bossbar
execute if score @s vt_child matches 1 if score @s vt_cstage matches 7 if score @s vt_bactive matches 1 if score @s vt_bstage matches 1 run function village_trader:bossbar/boss/task_1 with storage village_trader:runtime bossbar
execute if score @s vt_child matches 1 if score @s vt_cstage matches 7 if score @s vt_bactive matches 1 if score @s vt_bstage matches 2 run function village_trader:bossbar/boss/task_2 with storage village_trader:runtime bossbar
execute if score @s vt_child matches 1 if score @s vt_cstage matches 7 if score @s vt_bactive matches 1 if score @s vt_bstage matches 3 run function village_trader:bossbar/boss/task_3 with storage village_trader:runtime bossbar
execute if score @s vt_child matches 1 if score @s vt_cstage matches 7 if score @s vt_bstage matches 4 if score @s vt_asc matches 0 run function village_trader:bossbar/boss/ascension with storage village_trader:runtime bossbar
execute if score @s vt_child matches 1 if score @s vt_cstage matches 7 if score @s vt_bstage matches 4 if score @s vt_asc matches 1 run function village_trader:bossbar/boss/complete with storage village_trader:runtime bossbar
