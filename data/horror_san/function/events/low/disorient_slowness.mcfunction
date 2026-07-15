title @s times 5 25 10
title @s subtitle {"text":"有什么抓住了你的影子。","color":"gray"}
title @s title {"text":"快一点","color":"dark_red"}
effect give @s minecraft:slowness 3 1 true
execute at @s rotated as @s positioned ^ ^ ^-8 run playsound minecraft:entity.warden.nearby_closer master @s ~ ~ ~ 0.70 0.75
function horror_san:events/cooldown
