# 清除活动状态，保留仍被 tick 引用的计分板
function horror_san:disable
scoreboard players set @a horror_san.act 0
scoreboard players set #tick horror_san.tick 0
scoreboard players set #autostart horror_san.state 1
