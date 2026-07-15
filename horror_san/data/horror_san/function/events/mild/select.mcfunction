execute store result score @s horror_san.rng run random value 0..3
execute if score @s horror_san.rng matches 0 run function horror_san:events/mild/cave
execute if score @s horror_san.rng matches 1 run function horror_san:events/mild/enderman
execute if score @s horror_san.rng matches 2 run function horror_san:events/mild/whisper
execute if score @s horror_san.rng matches 3 run function horror_san:events/mild/footsteps
