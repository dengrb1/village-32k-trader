function village_trader:main/task/give_8
scoreboard players set @s vt_qown 8
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 8
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_d 0
scoreboard players add @s vt_pskull 0
scoreboard players operation @s vt_bskull = @s vt_pskull
title @s actionbar [{"text":"[村庄商人] 已激活「凋灵攻坚书」。从现在开始记录目标。","color":"green"}]
scoreboard players set @s vt_ui 7
function village_trader:ui/queue_reopen
