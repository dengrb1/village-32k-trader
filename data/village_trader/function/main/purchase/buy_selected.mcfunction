scoreboard players set @s vt_ok 1
execute unless score @s vt_good matches 1..30 run scoreboard players set @s vt_ok 0
execute unless score @s vt_buy_pending matches 1..64 run scoreboard players set @s vt_ok 0
function village_trader:main/purchase/check_selected_unlock
execute if score @s vt_ok matches 1 run function village_trader:main/purchase/check_selected_price
execute if score @s vt_ok matches 1 run function village_trader:main/purchase/pay_selected_price
execute if score @s vt_ok matches 1 run scoreboard players operation @s vt_tmp = @s vt_buy_pending
execute if score @s vt_ok matches 1 run function village_trader:main/purchase/give_selected
execute if score @s vt_ok matches 1 run title @s actionbar [{"text":"[村庄商人] 已完成原子批量购买：","color":"green"},{"score":{"name":"@s","objective":"vt_tmp"},"color":"aqua"},{"text":" 包。","color":"green"}]
execute if score @s vt_ok matches 0 run title @s actionbar {"text":"[村庄商人] 购买失败：商品未解锁、包数无效或总价材料不足；没有扣款也没有发货。","color":"red"}
scoreboard players set @s vt_buy_pending 0
