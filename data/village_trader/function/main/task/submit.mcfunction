execute if score @s vt_qactive matches 0 run title @s actionbar [{"text":"[村庄商人] 请先兑换并激活任务道具。","color":"yellow"}]
execute if score @s vt_qactive matches 11 run title @s actionbar [{"text":"[村庄商人] 十章主线已经完成。","color":"dark_purple"}]
execute if score @s vt_qactive matches 1 run function village_trader:main/task/submit_1
execute if score @s vt_qactive matches 2 run function village_trader:main/task/submit_2
execute if score @s vt_qactive matches 3 run function village_trader:main/task/submit_3
execute if score @s vt_qactive matches 4 run function village_trader:main/task/submit_4
execute if score @s vt_qactive matches 5 run function village_trader:main/task/submit_5
execute if score @s vt_qactive matches 6 run function village_trader:main/task/submit_6
execute if score @s vt_qactive matches 7 run function village_trader:main/task/submit_7
execute if score @s vt_qactive matches 8 run function village_trader:main/task/submit_8
execute if score @s vt_qactive matches 9 run function village_trader:main/task/submit_9
execute if score @s vt_qactive matches 10 run function village_trader:main/task/submit_10
