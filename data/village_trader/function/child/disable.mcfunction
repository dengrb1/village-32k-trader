execute unless entity @s[type=minecraft:player] run return 0
scoreboard players set @s vt_child 0
scoreboard players set @s vt_nvpause 0
scoreboard players set @s vt_nvsusp 0
tellraw @s [{"text":"[儿童守护线] ","color":"gold"},{"text":"已暂停；进度保留，商店恢复主线模式。儿童短时效果会自然过期，避免清除其他来源的同类效果。","color":"yellow"}]
