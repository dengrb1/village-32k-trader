schedule clear village_trader:scan
kill @e[type=minecraft:villager,tag=village_trader.merchant]
kill @e[type=minecraft:marker,tag=village_trader.house]
scoreboard objectives remove village_trader.penalty
tellraw @a [{"text":"[村庄商人] ","color":"gold"},{"text":"实体和定时任务已清理；已生成的房屋方块会保留。","color":"yellow"}]
