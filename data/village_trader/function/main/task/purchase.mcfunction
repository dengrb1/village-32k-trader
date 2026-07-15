execute if score @s vt_qactive matches 1..10 run title @s actionbar [{"text":"[村庄商人] 当前任务已激活，不能重复购买。","color":"red"}]
execute if score @s vt_qactive matches 1..10 run return 0
execute if score @s vt_qactive matches 11 run title @s actionbar [{"text":"[村庄商人] 十章主线已经完成。","color":"dark_purple"}]
execute if score @s vt_qactive matches 11 run return 0

execute if score @s vt_stage matches 2 if entity @s[tag=village_trader.legacy_contract_2] run function village_trader:main/task/legacy_2
execute if score @s vt_stage matches 3 if entity @s[tag=village_trader.legacy_contract_3] run function village_trader:main/task/legacy_3
execute if score @s vt_stage matches 5 if entity @s[tag=village_trader.legacy_contract_5] run function village_trader:main/task/legacy_5
execute if score @s vt_stage matches 6 if entity @s[tag=village_trader.legacy_contract_6] run function village_trader:main/task/legacy_6
execute if score @s vt_stage matches 8 if entity @s[tag=village_trader.legacy_contract_8] run function village_trader:main/task/legacy_8
execute if score @s vt_stage matches 9 if entity @s[tag=village_trader.legacy_contract_9] run function village_trader:main/task/legacy_9
execute if score @s vt_qactive matches 1..10 run return 0

execute if score @s vt_stage matches 1 run function village_trader:main/task/purchase_1
execute if score @s vt_stage matches 2 run function village_trader:main/task/purchase_2
execute if score @s vt_stage matches 3 run function village_trader:main/task/purchase_3
execute if score @s vt_stage matches 4 run function village_trader:main/task/purchase_4
execute if score @s vt_stage matches 5 run function village_trader:main/task/purchase_5
execute if score @s vt_stage matches 6 run function village_trader:main/task/purchase_6
execute if score @s vt_stage matches 7 run function village_trader:main/task/purchase_7
execute if score @s vt_stage matches 8 run function village_trader:main/task/purchase_8
execute if score @s vt_stage matches 9 run function village_trader:main/task/purchase_9
execute if score @s vt_stage matches 10 run function village_trader:main/task/purchase_10
execute if score @s vt_stage matches 11.. run title @s actionbar [{"text":"[村庄商人] 十章主线已经完成。","color":"dark_purple"}]
