execute unless score @s vt_stage matches 6.. run title @s actionbar [{"text":"[村庄商人] 尚未完成末地远征，20级装备尚未解锁。","color":"red"}]
execute unless score @s vt_stage matches 6.. run return 0
scoreboard players set @s vt_ok 1
function village_trader:purchase/check_goods_price
execute if score @s vt_ok matches 1 run function village_trader:purchase/pay_goods_price
execute if score @s vt_ok matches 1 run function village_trader:main/equipment/give_20
execute if score @s vt_ok matches 1 run advancement grant @s only village_trader:achievements/trade_04
execute if score @s vt_ok matches 1 run scoreboard players set @s vt_gear 3
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已兑换 20级传说整套装备。","color":"green"}]
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 当前制裁价格支付物不足。","color":"red"}]
