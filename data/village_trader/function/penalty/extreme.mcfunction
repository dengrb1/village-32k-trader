# 3级：所有交易支付 4 个下界合金锭。
scoreboard players set $level vt_penalty 3
function village_trader:penalty/refresh
tellraw @s [{"text":"[终焉黑市] ","color":"dark_purple","bold":true},{"text":"制裁设为三级：所有交易支付 4 个下界合金锭。","color":"dark_red"}]
