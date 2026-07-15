function village_trader:main/task/give_9
scoreboard players set @s vt_qown 9
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 9
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players add @s vt_pecho 0
scoreboard players operation @s vt_bpecho = @s vt_pecho
title @s actionbar [{"text":"[村庄商人] 已激活「深暗净化书」。从现在开始记录目标。","color":"green"}]
scoreboard players set @s vt_ui 7
function village_trader:ui/queue_reopen
