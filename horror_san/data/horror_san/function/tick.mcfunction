# 每刻清理幻象，并以 20 tick 为一秒节流
function horror_san:events/illusion_tick
scoreboard players add #tick horror_san.tick 1
execute if score #tick horror_san.tick matches 20.. run function horror_san:system/per_second
execute if score #tick horror_san.tick matches 20.. run scoreboard players set #tick horror_san.tick 0
