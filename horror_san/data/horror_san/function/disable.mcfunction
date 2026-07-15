# 停止体验并阻止再次自动启动
function horror_san:events/clear_illusions
scoreboard players set @a[tag=horror_san.experiencer] horror_san.act 0
tag @a[tag=horror_san.experiencer] remove horror_san.experiencer
bossbar set horror_san:san players @a[tag=horror_san.experiencer]
bossbar set horror_san:san visible false
scoreboard players set #autostart horror_san.state 1
