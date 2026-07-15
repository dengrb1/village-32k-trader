execute unless entity @s[type=minecraft:player] run return 0
scoreboard players set @s vt_nvsusp 2
effect clear @s minecraft:night_vision
title @s actionbar {"text":"儿童夜视已强制挂起并清除当前夜视效果。","color":"yellow"}

