title @s times 5 20 10
title @s subtitle {"text":"这一次，它离得很近。","color":"gray"}
title @s title {"text":"别呼吸","color":"dark_purple"}
effect give @s minecraft:darkness 2 0 true
playsound minecraft:block.sculk_shrieker.shriek master @s ~ ~ ~ 0.35 0.55
function horror_san:events/cooldown
