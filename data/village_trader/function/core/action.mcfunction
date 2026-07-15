# 所有购买与提交动作需要靠近商人，或持有本人已授权的便携钥匙。
scoreboard players operation @s vt_ui_last = @s vt_ui
execute if entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] run function village_trader:main/action
execute if entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] run function village_trader:child/action
execute unless entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] if score @s vt_portable matches 1 if entity @s[tag=village_trader.has_portable_key] run function village_trader:main/action
execute unless entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] if score @s vt_portable matches 1 if entity @s[tag=village_trader.has_portable_key] run function village_trader:child/action
execute unless entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] unless score @s vt_portable matches 1 run title @s actionbar {"text":"请靠近商人，或使用管理员发放的便携商店钥匙。","color":"red"}
execute unless entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..6] if score @s vt_portable matches 1 unless entity @s[tag=village_trader.has_portable_key] run title @s actionbar {"text":"便携商店钥匙不在身上，无法执行此操作。","color":"red"}
execute if score @s vt_ui = @s vt_ui_last if score @s vt_ui matches 1.. run function village_trader:ui/open_current
scoreboard players set @s vt_action 0
scoreboard players enable @s vt_action
