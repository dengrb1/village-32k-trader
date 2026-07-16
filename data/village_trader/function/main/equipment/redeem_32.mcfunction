execute unless score @s vt_stage matches 7.. run title @s actionbar {"text":"[村庄商人] 尚未解锁 32 级通行证。","color":"red"}
execute unless score @s vt_stage matches 7.. run return 0
scoreboard players set @s vt_gear 4
execute if entity @s[tag=village_trader.main_pass_32] run function village_trader:main/equipment/open_pass
execute if entity @s[tag=village_trader.main_pass_32] run return 0
scoreboard players set @s vt_ok 1
function village_trader:purchase/check_goods_price
execute if score @s vt_ok matches 1 run function village_trader:purchase/pay_goods_price
execute if score @s vt_ok matches 1 run tag @s add village_trader.main_pass_32
execute if score @s vt_ok matches 1 run advancement grant @s only village_trader:achievements/trade_05
execute if score @s vt_ok matches 1 run title @s actionbar {"text":"[村庄商人] 已购买 32 级装备通行证；现在可按需免费领取单件。","color":"green"}
execute if score @s vt_ok matches 1 run function village_trader:main/equipment/open_pass
execute if score @s vt_ok matches 0 run title @s actionbar {"text":"[村庄商人] 当前制裁价格支付物不足。","color":"red"}
