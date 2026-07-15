title @s times 5 20 10
title @s subtitle {"text":"灯光没有熄灭，是眼睛先暗了。","color":"gray"}
title @s title {"text":"看不清","color":"dark_purple"}
effect give @s minecraft:darkness 3 0 true
playsound minecraft:entity.warden.heartbeat master @s ~ ~ ~ 0.55 0.9
function horror_san:events/cooldown
