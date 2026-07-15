function village_trader:main/task/give_7
scoreboard players set @s vt_qown 7
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 7
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players add @s vt_utkey 0
scoreboard players operation @s vt_butkey = @s vt_utkey
title @s actionbar [{"text":"[村庄商人] 已激活「试炼密钥」。从现在开始记录目标。","color":"green"}]
scoreboard players set @s vt_ui 7
function village_trader:ui/queue_reopen
