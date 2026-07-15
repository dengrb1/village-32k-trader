# /trigger vt_menu 的统一入口：靠近商人或持有本人已绑定的钥匙时才可打开。
scoreboard players set @s vt_menu 0
execute if entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] run function village_trader:menu/open
execute unless entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] if score @s vt_portable matches 1 if entity @s[tag=village_trader.has_portable_key] run function village_trader:menu/open
execute unless entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] unless score @s vt_portable matches 1 run title @s actionbar {"text":"请靠近商人，或使用管理员发放的便携商店钥匙。","color":"red"}
execute unless entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] if score @s vt_portable matches 1 unless entity @s[tag=village_trader.has_portable_key] run title @s actionbar {"text":"已登记的便携商店钥匙不在身上。","color":"red"}
scoreboard players enable @s vt_menu
