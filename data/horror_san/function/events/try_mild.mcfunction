# SAN 41–69：低频异响或短句（10% / 秒，且无冷却时才抽取）。
execute store result score @s horror_san.rng run random value 0..99
execute if score @s horror_san.rng matches 0..9 run function horror_san:events/mild/select
