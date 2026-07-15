# 主线商店动作路由；公共层已限制玩家位于商人 6 格内。
execute unless score @s vt_child matches 0 run return 0

execute if score @s vt_action matches 1 run function village_trader:main/menu/root
execute if score @s vt_action matches 10 run function village_trader:main/menu/equipment
execute if score @s vt_action matches 20 run function village_trader:main/menu/resources
execute if score @s vt_action matches 30 run function village_trader:main/menu/consumables
execute if score @s vt_action matches 40 run function village_trader:main/menu/quest
execute if score @s vt_action matches 50 run function village_trader:main/menu/aids
execute if score @s vt_action matches 60 run function village_trader:main/menu/task
execute if score @s vt_action matches 70 run function village_trader:main/menu/settings

execute if score @s vt_action matches 101..110 run function village_trader:main/purchase/route_goods
execute if score @s vt_action matches 121 run function village_trader:main/task/purchase
execute if score @s vt_action matches 122 run function village_trader:main/task/reclaim
execute if score @s vt_action matches 123 run function village_trader:main/task/submit
execute if score @s vt_action matches 131..136 run function village_trader:main/purchase/route_aids
execute if score @s vt_action matches 141..146 run function village_trader:main/purchase/route_reclaim_aids
execute if score @s vt_action matches 150..157 run function village_trader:main/equipment/route
execute if score @s vt_action matches 170 run function village_trader:main/settings/normal
execute if score @s vt_action matches 171 run function village_trader:main/settings/hard
