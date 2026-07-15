execute if score @s vt_qactive matches 0 run title @s actionbar [{"text":"[村庄商人] 当前没有已激活任务。","color":"yellow"}]
execute if score @s vt_qactive matches 7 run title @s actionbar [{"text":"[村庄商人] 困难任务已经提交，不能补领。","color":"red"}]
execute if score @s vt_qactive matches 1 run function village_trader:main/task/reclaim_1
execute if score @s vt_qactive matches 2 run function village_trader:main/task/reclaim_2
execute if score @s vt_qactive matches 3 run function village_trader:main/task/reclaim_3
execute if score @s vt_qactive matches 4 run function village_trader:main/task/reclaim_4
execute if score @s vt_qactive matches 5 run function village_trader:main/task/reclaim_5
execute if score @s vt_qactive matches 6 run function village_trader:main/task/reclaim_6

