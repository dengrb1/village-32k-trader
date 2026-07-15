execute unless score @s vt_child matches 1 run title @s actionbar {"text":"儿童守护线未启用；管理员可执行 child/enable。","color":"yellow"}
execute unless score @s vt_child matches 1 run return 0
scoreboard players set @s vt_ui 21
function village_trader:ui/open_current
