execute store result score @s horror_san.rng run random value 0..4
execute if score @s horror_san.rng matches 0 run function horror_san:events/medium/darkness
execute if score @s horror_san.rng matches 1 run function horror_san:events/medium/nausea
execute if score @s horror_san.rng matches 2 run function horror_san:events/medium/slowness
execute if score @s horror_san.rng matches 3 run function horror_san:events/medium/heartbeat
execute if score @s horror_san.rng matches 4 run function horror_san:events/medium/echo
