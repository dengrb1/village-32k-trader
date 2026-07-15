function village_trader:main/task/give_2
scoreboard players set @s vt_qown 2
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 2
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players add @s vt_mdia 0
scoreboard players add @s vt_mddia 0
scoreboard players operation @s vt_bdia = @s vt_mdia
scoreboard players operation @s vt_bddia = @s vt_mddia
title @s actionbar [{"text":"[村庄商人] 已激活「矿脉勘探证」。从现在开始记录目标。","color":"green"}]
scoreboard players set @s vt_ui 7
function village_trader:ui/queue_reopen
