scoreboard players set @s vt_ok 0
execute if score @s vt_cgear matches 1 if score @s vt_cstage matches 1.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 3 if score @s vt_cstage matches 2.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 5 if score @s vt_cstage matches 3.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 10 if score @s vt_cstage matches 4.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 20 if score @s vt_cstage matches 5.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 32 if score @s vt_cstage matches 6.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 128 if score @s vt_asc matches 1.. run scoreboard players set @s vt_ok 1
execute unless score @s vt_ok matches 1 run title @s actionbar {"text":"当前儿童进度尚未解锁该等级通行证。","color":"red"}
execute unless score @s vt_ok matches 1 run return 0
execute if score @s vt_cgear matches 1 if entity @s[tag=village_trader.child_pass_1] run function village_trader:child/equipment/pass_home
execute if score @s vt_cgear matches 3 if entity @s[tag=village_trader.child_pass_3] run function village_trader:child/equipment/pass_home
execute if score @s vt_cgear matches 5 if entity @s[tag=village_trader.child_pass_5] run function village_trader:child/equipment/pass_home
execute if score @s vt_cgear matches 10 if entity @s[tag=village_trader.child_pass_10] run function village_trader:child/equipment/pass_home
execute if score @s vt_cgear matches 20 if entity @s[tag=village_trader.child_pass_20] run function village_trader:child/equipment/pass_home
execute if score @s vt_cgear matches 32 if entity @s[tag=village_trader.child_pass_32] run function village_trader:child/equipment/pass_home
execute if score @s vt_cgear matches 128 if entity @s[tag=village_trader.child_pass_128] run function village_trader:child/equipment/pass_home
execute if score @s vt_cgear matches 1 unless entity @s[tag=village_trader.child_pass_1] run function village_trader:child/equipment/pay_pass_1
execute if score @s vt_cgear matches 3 unless entity @s[tag=village_trader.child_pass_3] run function village_trader:child/equipment/pay_pass_3
execute if score @s vt_cgear matches 5 unless entity @s[tag=village_trader.child_pass_5] run function village_trader:child/equipment/pay_pass_5
execute if score @s vt_cgear matches 10 unless entity @s[tag=village_trader.child_pass_10] run function village_trader:child/equipment/pay_pass_10
execute if score @s vt_cgear matches 20 unless entity @s[tag=village_trader.child_pass_20] run function village_trader:child/equipment/pay_pass_20
execute if score @s vt_cgear matches 32 unless entity @s[tag=village_trader.child_pass_32] run function village_trader:child/equipment/pay_pass_32
execute if score @s vt_cgear matches 128 unless entity @s[tag=village_trader.child_pass_128] run function village_trader:child/equipment/pay_pass_128
