# 玩家靠近尚未布置商店的自然村庄时，建立一座商店。
execute as @a at @s if predicate village_trader:in_village unless entity @e[type=minecraft:marker,tag=village_trader.house,distance=..160] run function village_trader:create

# 房屋锚点会在商人被命令移除后自动补回商人。
execute as @e[type=minecraft:marker,tag=village_trader.house] at @s unless entity @e[type=minecraft:villager,tag=village_trader.merchant,distance=..8] run function village_trader:spawn_merchant

schedule function village_trader:scan 5s replace
