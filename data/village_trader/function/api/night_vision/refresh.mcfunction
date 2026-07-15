execute unless entity @s[type=minecraft:player] run return 0
execute if score @s vt_child matches 1 if score @s vt_nvpause matches 0 if score @s vt_nvsusp matches 0 run effect give @s minecraft:night_vision 4 0 true

