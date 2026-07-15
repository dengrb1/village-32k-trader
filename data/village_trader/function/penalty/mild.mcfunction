# 1级：所有交易支付 16 个泥土。
scoreboard players set $level village_trader.penalty 1
function village_trader:penalty/refresh
tellraw @s [{"text":"[终焉黑市] ","color":"dark_purple","bold":true},{"text":"制裁设为一级：所有交易支付 16 个泥土。","color":"yellow"}]
