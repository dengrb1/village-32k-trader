execute unless score @s vt_stage matches 7.. run title @s actionbar [{"text":"[村庄商人] 尚未完成村庄守卫，32级装备尚未解锁。","color":"red"}]
execute unless score @s vt_stage matches 7.. run return 0
scoreboard players set @s vt_ok 1
function village_trader:purchase/check_goods_price
execute if score @s vt_ok matches 1 run function village_trader:purchase/pay_goods_price
execute if score @s vt_ok matches 1 run function village_trader:main/equipment/give_32
execute if score @s vt_ok matches 1 run advancement grant @s only village_trader:achievements/trade_05
execute if score @s vt_ok matches 1 run scoreboard players set @s vt_gear 4
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已兑换 32级神话整套装备。","color":"green"}]
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 当前制裁价格支付物不足。","color":"red"}]
