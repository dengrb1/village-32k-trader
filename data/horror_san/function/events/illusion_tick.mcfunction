# 每游戏刻由根 tick 调用一次，确保幻象在 40 tick 后消失。
execute as @e[tag=horror_san.illusion] run scoreboard players remove @s horror_san.age 1
kill @e[tag=horror_san.illusion,scores={horror_san.age=..0}]
