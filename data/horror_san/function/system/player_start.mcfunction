# 新体验者从满 SAN 开始
scoreboard players set @s horror_san.san 100
scoreboard players set @s horror_san.act 1
scoreboard players set @s horror_san.cd 0
scoreboard players set @s horror_san.rng 0
scoreboard players set @s horror_san.age 0
bossbar set horror_san:san players @a[tag=horror_san.experiencer,scores={horror_san.act=1..}]
function horror_san:system/update_bossbar
