execute if score @s vt_qactive matches 1..6 run title @s actionbar [{"text":"[村庄商人] 当前任务已激活，不能重复购买。","color":"red"}]
execute if score @s vt_qactive matches 1..6 run return 0
execute if score @s vt_qactive matches 7 run title @s actionbar [{"text":"[村庄商人] 困难主线已经完成。","color":"dark_purple"}]
execute if score @s vt_qactive matches 7 run return 0
execute if score @s vt_stage matches 1 run function village_trader:main/task/purchase_1
execute if score @s vt_stage matches 2 run function village_trader:main/task/purchase_2
execute if score @s vt_stage matches 3 run function village_trader:main/task/purchase_3
execute if score @s vt_stage matches 4 run function village_trader:main/task/purchase_4
execute if score @s vt_stage matches 5 run function village_trader:main/task/purchase_5
execute if score @s vt_stage matches 6 if score @s vt_diff matches 0 run title @s actionbar [{"text":"[村庄商人] 请先切换困难商店再兑换深暗挑战书。","color":"yellow"}]
execute if score @s vt_stage matches 6 if score @s vt_diff matches 1 run function village_trader:main/task/purchase_6

