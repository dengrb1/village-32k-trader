# 每秒读取世界时间；首次夜晚自动选定一名体验者
execute store result score #daytime horror_san.time run time query minecraft:day
execute if score #autostart horror_san.state matches 0 if score #daytime horror_san.time matches 13000..22999 run function horror_san:system/auto_start
execute as @a[tag=horror_san.experiencer,scores={horror_san.act=1..}] at @s run function horror_san:system/update_san
execute as @a[tag=horror_san.experiencer,scores={horror_san.act=1..}] run function horror_san:system/update_bossbar
# 恐怖事件在 SAN 与 BossBar 同步后判定
function horror_san:events/tick
