# SAN 21–40：提高到 25%，并加入短暂状态效果。
execute store result score @s horror_san.rng run random value 0..99
execute if score @s horror_san.rng matches 0..24 run function horror_san:events/medium/select
