# SAN 0–20：较高频率；幻象和快捷栏交换只会从这里进入。
execute store result score @s horror_san.rng run random value 0..99
execute if score @s horror_san.rng matches 0..54 run function horror_san:events/low/select
