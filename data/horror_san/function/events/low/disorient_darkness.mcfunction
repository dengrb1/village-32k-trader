title @s times 5 25 10
title @s subtitle {"text":"黑暗里有人比你先眨眼。","color":"gray"}
title @s title {"text":"不要看","color":"dark_purple"}
effect give @s minecraft:darkness 3 0 true
execute at @s rotated as @s positioned ^ ^ ^-6 run playsound minecraft:entity.warden.nearby_closer master @s ~ ~ ~ 0.65 0.8
function horror_san:events/cooldown
