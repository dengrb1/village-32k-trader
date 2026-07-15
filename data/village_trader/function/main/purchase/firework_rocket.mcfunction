execute unless score @s vt_stage matches 11.. run title @s actionbar [{"text":"[村庄商人] 完成龙魂再临后才会开放烟花火箭。","color":"red"}]
execute unless score @s vt_stage matches 11.. run return 0
scoreboard players set @s vt_ok 1
function village_trader:purchase/check_goods_price
execute if score @s vt_ok matches 1 run function village_trader:purchase/pay_goods_price
execute if score @s vt_ok matches 1 run give @s minecraft:firework_rocket[minecraft:fireworks={flight_duration:3}] 64
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已兑换 烟花火箭×64。","color":"green"}]
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 支付物不足，当前制裁价格无法结算。","color":"red"}]
