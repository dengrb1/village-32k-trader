title @s times 5 20 10
title @s subtitle {"text":"地面正在缓慢倾斜。","color":"gray"}
title @s title {"text":"站稳","color":"dark_red"}
effect give @s minecraft:nausea 3 0 true
playsound minecraft:entity.warden.heartbeat master @s ~ ~ ~ 0.50 0.8
function horror_san:events/cooldown
