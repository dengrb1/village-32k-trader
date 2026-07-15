execute store result score @s horror_san.rng run random value 0..2
execute if score @s horror_san.rng matches 0 run function horror_san:events/low/disorient_darkness
execute if score @s horror_san.rng matches 1 run function horror_san:events/low/disorient_nausea
execute if score @s horror_san.rng matches 2 run function horror_san:events/low/disorient_slowness
