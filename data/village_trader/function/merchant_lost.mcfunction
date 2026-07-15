# 以房屋锚点为执行者：商人死亡或被移除时升级制裁、重设交易并补回商人。
function village_trader:penalty/increase
function village_trader:penalty/refresh
function village_trader:spawn_merchant
execute if score $level village_trader.penalty matches 1 run tellraw @a [{"text":"[终焉黑市] ","color":"dark_purple","bold":true},{"text":"商人被击杀！全网交易涨至 16 个泥土。","color":"red"}]
execute if score $level village_trader.penalty matches 2 run tellraw @a [{"text":"[终焉黑市] ","color":"dark_purple","bold":true},{"text":"黑市震怒：所有交易改为 16 个绿宝石。","color":"red"}]
execute if score $level village_trader.penalty matches 3 run tellraw @a [{"text":"[终焉黑市] ","color":"dark_purple","bold":true},{"text":"终焉制裁：所有交易改为 4 个下界合金锭。","color":"dark_red"}]
