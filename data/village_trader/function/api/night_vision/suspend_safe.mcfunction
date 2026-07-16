execute unless entity @s[type=minecraft:player] run return 0
scoreboard players set @s vt_nvsusp 1
title @s actionbar {"text":"儿童夜视已安全挂起；当前效果会自然过期，不会主动清除其他来源。","color":"yellow"}

