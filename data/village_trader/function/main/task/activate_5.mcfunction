function village_trader:main/task/give_5
scoreboard players set @s vt_qown 5
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 5
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
title @s actionbar [{"text":"[村庄商人] 已激活「末地远征证」。从现在开始记录目标。","color":"green"}]
scoreboard players set @s vt_ui 7
function village_trader:ui/queue_reopen
