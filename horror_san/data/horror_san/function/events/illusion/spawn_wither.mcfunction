# 此函数继承候选位置。三格净空与地面检查已在调用方完成。
title @s times 5 20 10
title @s subtitle {"text":"阴影没有跟着你停下。","color":"gray"}
title @s title {"text":"不要回头","color":"dark_purple"}
effect give @s minecraft:darkness 2 0 true
playsound minecraft:entity.warden.nearby_closer master @s ~ ~ ~ 0.65 0.8
summon minecraft:wither_skeleton ~ ~ ~ {NoAI:1b,Silent:1b,Invulnerable:1b,NoGravity:1b,PersistenceRequired:1b,CanPickUpLoot:0b,DeathLootTable:"minecraft:empty",Tags:["horror_san.illusion"],HandItems:[{},{}],ArmorItems:[{},{},{},{}],HandDropChances:[0.0f,0.0f],ArmorDropChances:[0.0f,0.0f,0.0f,0.0f]}
scoreboard players set @e[tag=horror_san.illusion,distance=..1,limit=1,sort=nearest] horror_san.age 40
function horror_san:events/cooldown
