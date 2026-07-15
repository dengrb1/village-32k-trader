# 0级：1个泥土交易。
scoreboard players set $level village_trader.penalty 0
function village_trader:penalty/refresh
tellraw @s [{"text":"[终焉黑市] ","color":"dark_purple","bold":true},{"text":"制裁已解除：交易恢复为 1 个泥土。","color":"green"}]
