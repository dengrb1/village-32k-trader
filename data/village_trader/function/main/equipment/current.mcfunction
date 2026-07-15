execute if score @s vt_gear matches 1 run function village_trader:main/equipment/redeem_5
execute if score @s vt_gear matches 2 run function village_trader:main/equipment/redeem_10
execute if score @s vt_gear matches 3 run function village_trader:main/equipment/redeem_20
execute if score @s vt_gear matches 4 run function village_trader:main/equipment/redeem_32
execute if score @s vt_gear matches 5 run function village_trader:main/equipment/redeem_64
execute if score @s vt_gear matches 7 run function village_trader:main/equipment/redeem_255
execute if score @s vt_gear matches 1..7 run return 0
execute if score @s vt_stage matches 1 run title @s actionbar [{"text":"[村庄商人] 第一阶段尚未解锁成长装备。","color":"yellow"}]
execute if score @s vt_stage matches 2 run function village_trader:main/equipment/redeem_5
execute if score @s vt_stage matches 3 run function village_trader:main/equipment/redeem_10
execute if score @s vt_stage matches 4 run function village_trader:main/equipment/redeem_20
execute if score @s vt_stage matches 5 run function village_trader:main/equipment/redeem_32
execute if score @s vt_stage matches 6 if score @s vt_diff matches 0 run function village_trader:main/equipment/redeem_64
execute if score @s vt_stage matches 6 if score @s vt_diff matches 1 unless score @s vt_qactive matches 7 run function village_trader:main/equipment/redeem_32
execute if score @s vt_stage matches 6 if score @s vt_diff matches 1 if score @s vt_qactive matches 7 run function village_trader:main/equipment/redeem_255
