# 每次循环只发一个“商品包”，因而 1–64 包不会因 give 上限而丢失物品。
execute unless score @s vt_buy_pending matches 1.. run return 0
function village_trader:main/purchase/give_selected_one
scoreboard players remove @s vt_buy_pending 1
execute if score @s vt_buy_pending matches 1.. run function village_trader:main/purchase/give_selected
