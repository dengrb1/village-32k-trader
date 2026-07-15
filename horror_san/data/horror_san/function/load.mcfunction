# 初始化 SAN 与事件计分板
scoreboard objectives add horror_san.san dummy
scoreboard objectives add horror_san.act dummy
scoreboard objectives add horror_san.cd dummy
scoreboard objectives add horror_san.rng dummy
scoreboard objectives add horror_san.age dummy
scoreboard objectives add horror_san.tick dummy
scoreboard objectives add horror_san.state dummy
scoreboard objectives add horror_san.time dummy
scoreboard objectives add horror_san.k dummy
scoreboard players set #twenty horror_san.k 20
execute unless score #tick horror_san.tick matches -2147483648..2147483647 run scoreboard players set #tick horror_san.tick 0
execute unless score #autostart horror_san.state matches -2147483648..2147483647 run scoreboard players set #autostart horror_san.state 0
# 仅在尚未存在时创建 BossBar
execute store success score #bossbar horror_san.state run bossbar get horror_san:san value
execute if score #bossbar horror_san.state matches 0 run bossbar add horror_san:san {"text":"SAN","color":"green"}
bossbar set horror_san:san max 100
bossbar set horror_san:san players @a[tag=horror_san.experiencer,scores={horror_san.act=1..}]
execute as @a[tag=horror_san.experiencer,scores={horror_san.act=1..}] run function horror_san:system/update_bossbar
execute unless entity @a[tag=horror_san.experiencer,scores={horror_san.act=1..}] run bossbar set horror_san:san visible false
