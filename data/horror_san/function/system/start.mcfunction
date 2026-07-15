# 清理旧选择后只保留一名体验者
tag @a[tag=horror_san.experiencer] remove horror_san.experiencer
tag @a[gamemode=!spectator,limit=1,sort=arbitrary] add horror_san.experiencer
execute as @a[tag=horror_san.experiencer] run function horror_san:system/player_start
