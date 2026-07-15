# 成功事件后写入的冷却以秒为单位递减。
execute if score @s horror_san.cd matches 1.. run scoreboard players remove @s horror_san.cd 1
execute unless score @s horror_san.cd matches 1.. run function horror_san:events/try
