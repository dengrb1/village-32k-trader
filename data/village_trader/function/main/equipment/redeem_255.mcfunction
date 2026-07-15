execute unless score @s vt_stage matches 6 run title @s actionbar [{"text":"[村庄商人] 尚未达到普通第六阶段。","color":"red"}]
execute unless score @s vt_stage matches 6 run return 0
execute unless score @s vt_qactive matches 7 run title @s actionbar [{"text":"[村庄商人] 必须先完成深暗挑战并提交挑战书。","color":"red"}]
execute unless score @s vt_qactive matches 7 run return 0
scoreboard players set @s vt_ok 1
function village_trader:purchase/check_goods_price
execute if score @s vt_ok matches 1 run function village_trader:purchase/pay_goods_price
execute if score @s vt_ok matches 1 run function village_trader:main/equipment/give_255
execute if score @s vt_ok matches 1 run scoreboard players set @s vt_gear 7
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已兑换 255 级 32K「终焉主宰」整套装备。","color":"dark_purple","bold":true}]
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 当前制裁价格支付物不足。","color":"red"}]

