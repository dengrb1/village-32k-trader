# 2级：所有交易支付 16 个绿宝石。
scoreboard players set $level vt_penalty 2
function village_trader:penalty/refresh
tellraw @s [{"text":"[终焉黑市] ","color":"dark_purple","bold":true},{"text":"制裁设为二级：所有交易支付 16 个绿宝石。","color":"gold"}]
