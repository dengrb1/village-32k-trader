execute unless score @s vt_stage matches 11.. unless entity @s[tag=village_trader.legacy_255] run title @s actionbar [{"text":"[村庄商人] 完成龙魂再临后才可兑换 255 级装备。","color":"red"}]
execute unless score @s vt_stage matches 11.. unless entity @s[tag=village_trader.legacy_255] run return 0
scoreboard players set @s vt_ok 1
function village_trader:purchase/check_goods_price
execute if score @s vt_ok matches 1 run function village_trader:purchase/pay_goods_price
execute if score @s vt_ok matches 1 run function village_trader:main/equipment/give_255
execute if score @s vt_ok matches 1 run advancement grant @s only village_trader:achievements/trade_07
execute if score @s vt_ok matches 1 run scoreboard players set @s vt_gear 7
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已兑换 255 级 32K「终焉主宰」整套装备。","color":"dark_purple","bold":true}]
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 当前制裁价格支付物不足。","color":"red"}]

