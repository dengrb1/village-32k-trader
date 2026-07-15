execute unless score @s vt_stage matches 6.. run title @s actionbar [{"text":"[村庄商人] 尚未解锁 64级普通终焉整套装备。","color":"red"}]
execute unless score @s vt_stage matches 6.. run return 0
execute if score @s vt_diff matches 1 unless score @s vt_qactive matches 7 run title @s actionbar [{"text":"[村庄商人] 困难深暗挑战完成前，装备兑换暂时锁定在 32 级。","color":"yellow"}]
execute if score @s vt_diff matches 1 unless score @s vt_qactive matches 7 run return 0
scoreboard players set @s vt_ok 1
function village_trader:purchase/check_goods_price
execute if score @s vt_ok matches 1 run function village_trader:purchase/pay_goods_price
execute if score @s vt_ok matches 1 run function village_trader:main/equipment/give_64
execute if score @s vt_ok matches 1 run scoreboard players set @s vt_gear 5
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已兑换 64级普通终焉整套装备。","color":"green"}]
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 当前制裁价格支付物不足。","color":"red"}]
