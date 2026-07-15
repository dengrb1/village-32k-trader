execute unless score @s vt_child matches 1 run return 0
execute unless score @s vt_cstage matches 1..6 run title @s actionbar {"text":"当前没有核心任务牌。","color":"yellow"}
execute unless score @s vt_cstage matches 1..6 run return 0
execute if score @s vt_cqown matches 1 run title @s actionbar {"text":"你已经拥有当前任务牌的个人所有权；丢失时请使用补领。","color":"yellow"}
execute if score @s vt_cqown matches 1 run return 0
scoreboard players set @s vt_ok 0
execute if score @s vt_cstage matches 1 run function village_trader:child/task/buy_1
execute if score @s vt_cstage matches 2 run function village_trader:child/task/buy_2
execute if score @s vt_cstage matches 3 run function village_trader:child/task/buy_3
execute if score @s vt_cstage matches 4 run function village_trader:child/task/buy_4
execute if score @s vt_cstage matches 5 run function village_trader:child/task/buy_5
execute if score @s vt_cstage matches 6 run function village_trader:child/task/buy_6
execute unless score @s vt_ok matches 1 run return 0
scoreboard players set @s vt_cqown 1
scoreboard players set @s vt_cqrep 0
scoreboard players set @s vt_cactive 1
scoreboard players set @s vt_ca 0
scoreboard players set @s vt_cb 0
scoreboard players set @s vt_cc 0
execute if score @s vt_cstage matches 2 run scoreboard players operation @s vt_cbcob = @s vt_mcob
execute if score @s vt_cstage matches 5 run scoreboard players operation @s vt_cbdia = @s vt_mdia
execute if score @s vt_cstage matches 5 run scoreboard players operation @s vt_cbddia = @s vt_mddia
title @s actionbar {"text":"任务牌已兑换并绑定个人所有权；本章目标现在开始计数。","color":"green"}
