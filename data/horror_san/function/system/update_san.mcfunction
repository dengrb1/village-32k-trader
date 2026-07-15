# 夜晚、低照度、雷暴分别降低 1 点；明亮白天恢复 1 点
execute if score #daytime horror_san.time matches 13000..22999 run scoreboard players remove @s horror_san.san 1
execute if predicate horror_san:low_light run scoreboard players remove @s horror_san.san 1
execute if predicate horror_san:thundering run scoreboard players remove @s horror_san.san 1
execute if score #daytime horror_san.time matches 0..12999 unless predicate horror_san:low_light unless predicate horror_san:thundering run scoreboard players add @s horror_san.san 1
# 始终限制在 0 至 100
execute if score @s horror_san.san matches ..-1 run scoreboard players set @s horror_san.san 0
execute if score @s horror_san.san matches 101.. run scoreboard players set @s horror_san.san 100
