# 无 AI、无声、无敌且无掉落；只作为两秒的视觉幻象。
title @s times 5 20 10
title @s subtitle {"text":"它没有眨眼。","color":"gray"}
title @s title {"text":"别看它","color":"dark_purple"}
effect give @s minecraft:darkness 2 0 true
playsound minecraft:entity.enderman.stare master @s ~ ~ ~ 0.60 0.8
summon minecraft:enderman ~ ~ ~ {NoAI:1b,Silent:1b,Invulnerable:1b,NoGravity:1b,PersistenceRequired:1b,CanPickUpLoot:0b,DeathLootTable:"minecraft:empty",Tags:["horror_san.illusion"],HandItems:[{},{}],ArmorItems:[{},{},{},{}],HandDropChances:[0.0f,0.0f],ArmorDropChances:[0.0f,0.0f,0.0f,0.0f]}
scoreboard players set @e[tag=horror_san.illusion,distance=..1,limit=1,sort=nearest] horror_san.age 40
function horror_san:events/cooldown
