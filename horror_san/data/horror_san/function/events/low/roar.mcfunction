title @s times 5 20 10
title @s subtitle {"text":"门外传来一声回答。","color":"gray"}
title @s title {"text":"别开门","color":"dark_red"}
effect give @s minecraft:darkness 2 0 true
playsound minecraft:entity.warden.roar master @s ~ ~ ~ 0.40 0.6
function horror_san:events/cooldown
