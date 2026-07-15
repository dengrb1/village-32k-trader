# ExplosionRadius:0 防止即使被外力点燃也造成伤害或破坏。
title @s times 5 20 10
title @s subtitle {"text":"它在等你发现它。","color":"gray"}
title @s title {"text":"别动","color":"dark_green"}
effect give @s minecraft:darkness 2 0 true
playsound minecraft:entity.creeper.primed master @s ~ ~ ~ 0.55 0.8
summon minecraft:creeper ~ ~ ~ {NoAI:1b,Silent:1b,Invulnerable:1b,NoGravity:1b,PersistenceRequired:1b,CanPickUpLoot:0b,ExplosionRadius:0b,Fuse:32767s,ignited:0b,DeathLootTable:"minecraft:empty",Tags:["horror_san.illusion"],HandItems:[{},{}],ArmorItems:[{},{},{},{}],HandDropChances:[0.0f,0.0f],ArmorDropChances:[0.0f,0.0f,0.0f,0.0f]}
scoreboard players set @e[tag=horror_san.illusion,distance=..1,limit=1,sort=nearest] horror_san.age 40
function horror_san:events/cooldown
