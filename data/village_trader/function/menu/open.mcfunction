# 儿童线启用时显示儿童商店，否则显示主线商店。
execute if score @s vt_child matches 1 run function village_trader:child/menu/root
execute unless score @s vt_child matches 1 run function village_trader:main/menu/root
