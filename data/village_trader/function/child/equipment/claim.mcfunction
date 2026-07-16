scoreboard players set @s vt_ok 0
execute if score @s vt_cgear matches 1 if entity @s[tag=village_trader.child_pass_1] run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 3 if entity @s[tag=village_trader.child_pass_3] run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 5 if entity @s[tag=village_trader.child_pass_5] run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 10 if entity @s[tag=village_trader.child_pass_10] run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 20 if entity @s[tag=village_trader.child_pass_20] run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 32 if entity @s[tag=village_trader.child_pass_32] run scoreboard players set @s vt_ok 1
execute if score @s vt_cgear matches 128 if entity @s[tag=village_trader.child_pass_128] run scoreboard players set @s vt_ok 1
execute unless score @s vt_cequip_slot matches 1..12 run scoreboard players set @s vt_ok 0
execute if score @s vt_ok matches 1 if score @s vt_cgear matches 1 run function village_trader:child/equipment/tier_1
execute if score @s vt_ok matches 1 if score @s vt_cgear matches 3 run function village_trader:child/equipment/tier_3
execute if score @s vt_ok matches 1 if score @s vt_cgear matches 5 run function village_trader:child/equipment/tier_5
execute if score @s vt_ok matches 1 if score @s vt_cgear matches 10 run function village_trader:child/equipment/tier_10
execute if score @s vt_ok matches 1 if score @s vt_cgear matches 20 run function village_trader:child/equipment/tier_20
execute if score @s vt_ok matches 1 if score @s vt_cgear matches 32 run function village_trader:child/equipment/tier_32
execute if score @s vt_ok matches 1 if score @s vt_cgear matches 128 run function village_trader:child/equipment/tier_128
execute if score @s vt_ok matches 1 run title @s actionbar {"text":"已按需免费领取一件儿童通行证装备。","color":"green"}
execute if score @s vt_ok matches 0 run title @s actionbar {"text":"未持有该等级儿童装备通行证。","color":"red"}
