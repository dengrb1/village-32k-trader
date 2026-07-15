execute store result score @s horror_san.rng run random value 0..1
execute if score @s horror_san.rng matches 0 run function horror_san:events/low/shriek
execute if score @s horror_san.rng matches 1 run function horror_san:events/low/roar
