# 每秒由 system/per_second 调用；只处理当前唯一体验者。
execute as @a[tag=horror_san.experiencer,limit=1] at @s run function horror_san:events/player_tick
