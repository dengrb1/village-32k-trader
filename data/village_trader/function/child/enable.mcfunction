# 由管理员使用 execute as <玩家> 调用；权限由 /function 命令本身保证。
execute unless entity @s[type=minecraft:player] run return 0
scoreboard players set @s vt_child 1
execute unless score @s vt_cstage matches 1..7 run scoreboard players set @s vt_cstage 1
execute unless score @s vt_bstage matches 1..4 run scoreboard players set @s vt_bstage 1
scoreboard players enable @s vt_action
title @s actionbar {"text":"儿童守护线已启用；原有进度已保留。","color":"green"}
function village_trader:menu/open
function village_trader:api/night_vision/refresh
