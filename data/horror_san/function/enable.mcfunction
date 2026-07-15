# 立即开始一次单人测试
function horror_san:events/clear_illusions
tag @a[tag=horror_san.experiencer] remove horror_san.experiencer
# 由玩家执行时优先让执行者成为体验者；控制台则回退为随机在线玩家。
execute as @s[gamemode=!spectator] run tag @s add horror_san.experiencer
execute unless entity @a[tag=horror_san.experiencer] run function horror_san:system/start
execute as @a[tag=horror_san.experiencer] run function horror_san:system/player_start
execute if entity @a[tag=horror_san.experiencer,scores={horror_san.act=1..}] run scoreboard players set #autostart horror_san.state 1
