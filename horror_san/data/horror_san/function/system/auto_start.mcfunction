# 有玩家时记录首次夜晚并开始体验
function horror_san:system/start
execute if entity @a[tag=horror_san.experiencer,scores={horror_san.act=1..}] run scoreboard players set #autostart horror_san.state 1
