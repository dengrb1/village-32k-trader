title @s times 5 25 10
title @s subtitle {"text":"走廊忽然变得很长。","color":"gray"}
title @s title {"text":"别停下","color":"dark_red"}
effect give @s minecraft:nausea 3 0 true
execute at @s rotated as @s positioned ^ ^ ^-7 run playsound minecraft:entity.warden.nearby_closer master @s ~ ~ ~ 0.60 0.7
function horror_san:events/cooldown
