execute unless score @s vt_stage matches 9.. run title @s actionbar [{"text":"[村庄商人] 尚未解锁：下界合金块×4。","color":"red"}]
execute unless score @s vt_stage matches 9.. run return 0
scoreboard players set @s vt_ok 1
function village_trader:purchase/check_goods_price
execute if score @s vt_ok matches 1 run function village_trader:purchase/pay_goods_price
execute if score @s vt_ok matches 1 run give @s minecraft:netherite_block 4
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已兑换 下界合金块×4。","color":"green"}]
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 支付物不足，当前制裁价格无法结算。","color":"red"}]

