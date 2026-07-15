# 公共每秒入口；主线和儿童线各自维护业务效果。
execute if data storage village_trader:state installed as @a at @s run function village_trader:main/second_player
execute if data storage village_trader:state installed as @a at @s run function village_trader:child/second_player
execute if data storage village_trader:state installed run schedule function village_trader:second 1s replace
