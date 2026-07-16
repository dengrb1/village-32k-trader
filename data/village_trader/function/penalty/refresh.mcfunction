# 重新生成全部现存商人的交易，使当前制裁立即生效。
execute as @e[type=minecraft:villager,tag=village_trader.merchant] run function village_trader:set_trades
