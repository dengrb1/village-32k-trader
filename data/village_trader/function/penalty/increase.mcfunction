# 每次商人死亡/消失提升一级，全局制裁最高为三级。
scoreboard players add $level village_trader.penalty 1
execute if score $level village_trader.penalty matches 4.. run scoreboard players set $level village_trader.penalty 3
