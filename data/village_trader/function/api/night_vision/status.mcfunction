execute unless entity @s[type=minecraft:player] run return 0
title @s actionbar [{"text":"儿童夜视：启用=","color":"light_purple"},{"score":{"name":"@s","objective":"vt_child"}},{"text":" 暂停=","color":"gray"},{"score":{"name":"@s","objective":"vt_nvpause"}},{"text":"秒 挂起=","color":"gray"},{"score":{"name":"@s","objective":"vt_nvsusp"}},{"text":"（0正常/1安全/2强制）","color":"gray"}]
