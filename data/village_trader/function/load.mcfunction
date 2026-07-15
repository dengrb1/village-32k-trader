# 村庄 32K 商人数据包加载入口
scoreboard objectives add village_trader.penalty dummy
tellraw @a [{"text":"[村庄商人] ","color":"gold"},{"text":"数据包已加载（Java 26.1.2）","color":"green"}]
function village_trader:penalty/refresh
schedule function village_trader:scan 1s replace
