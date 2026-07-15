execute unless entity @s[type=minecraft:player] run return 0
execute unless score @s vt_child matches 1 run title @s actionbar {"text":"儿童线未启用，夜视状态已解除挂起但不会续期。","color":"yellow"}
scoreboard players set @s vt_nvpause 0
scoreboard players set @s vt_nvsusp 0
function village_trader:api/night_vision/refresh
execute if score @s vt_child matches 1 run title @s actionbar {"text":"儿童夜视已恢复。","color":"green"}
