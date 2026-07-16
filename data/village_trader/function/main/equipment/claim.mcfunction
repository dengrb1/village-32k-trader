scoreboard players set @s vt_ok 0
execute if score @s vt_gear matches 1 if entity @s[tag=village_trader.main_pass_5] run scoreboard players set @s vt_ok 1
execute if score @s vt_gear matches 2 if entity @s[tag=village_trader.main_pass_10] run scoreboard players set @s vt_ok 1
execute if score @s vt_gear matches 3 if entity @s[tag=village_trader.main_pass_20] run scoreboard players set @s vt_ok 1
execute if score @s vt_gear matches 4 if entity @s[tag=village_trader.main_pass_32] run scoreboard players set @s vt_ok 1
execute if score @s vt_gear matches 5 if entity @s[tag=village_trader.main_pass_64] run scoreboard players set @s vt_ok 1
execute if score @s vt_gear matches 7 if entity @s[tag=village_trader.main_pass_255] run scoreboard players set @s vt_ok 1
execute unless score @s vt_equip_slot matches 1..17 run scoreboard players set @s vt_ok 0
execute if score @s vt_ok matches 1 if score @s vt_gear matches 1 run function village_trader:main/equipment/give_5
execute if score @s vt_ok matches 1 if score @s vt_gear matches 2 run function village_trader:main/equipment/give_10
execute if score @s vt_ok matches 1 if score @s vt_gear matches 3 run function village_trader:main/equipment/give_20
execute if score @s vt_ok matches 1 if score @s vt_gear matches 4 run function village_trader:main/equipment/give_32
execute if score @s vt_ok matches 1 if score @s vt_gear matches 5 run function village_trader:main/equipment/give_64
execute if score @s vt_ok matches 1 if score @s vt_gear matches 7 run function village_trader:main/equipment/give_255
execute if score @s vt_ok matches 1 run title @s actionbar {"text":"[村庄商人] 已按需免费领取一件通行证装备。","color":"green"}
execute if score @s vt_ok matches 0 run title @s actionbar {"text":"[村庄商人] 未持有当前等级通行证，不能领取该物品。","color":"red"}
