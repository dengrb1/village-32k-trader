execute store result score @s horror_san.rng run random value 0..99
execute if score @s horror_san.rng matches 0..44 run function horror_san:events/low/disorient
execute if score @s horror_san.rng matches 45..89 run function horror_san:events/illusion/select
execute if score @s horror_san.rng matches 90..94 run function horror_san:events/hotbar/select
execute if score @s horror_san.rng matches 95..99 run function horror_san:events/low/rare
