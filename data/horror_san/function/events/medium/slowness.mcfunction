title @s times 5 20 10
title @s subtitle {"text":"脚步被什么拖住了。","color":"gray"}
title @s title {"text":"别回头","color":"dark_red"}
effect give @s minecraft:slowness 3 0 true
playsound minecraft:entity.warden.heartbeat master @s ~ ~ ~ 0.60 0.75
function horror_san:events/cooldown
