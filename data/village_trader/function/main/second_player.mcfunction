# 每秒执行：封顶任务计数、辅助用品效果和困难套装效果。
execute unless score @s vt_child matches 0 run return 0
execute if score @s vt_qactive matches 1 if score @s vt_a matches 2.. run scoreboard players set @s vt_a 1
execute if score @s vt_qactive matches 1 if score @s vt_b matches 2.. run scoreboard players set @s vt_b 1
execute if score @s vt_qactive matches 2 if score @s vt_a matches 9.. run scoreboard players set @s vt_a 8
execute if score @s vt_qactive matches 2 if score @s vt_b matches 21.. run scoreboard players set @s vt_b 20
execute if score @s vt_qactive matches 3 if score @s vt_a matches 2.. run scoreboard players set @s vt_a 1
execute if score @s vt_qactive matches 3 if score @s vt_b matches 11.. run scoreboard players set @s vt_b 10
execute if score @s vt_qactive matches 3 if score @s vt_c matches 5.. run scoreboard players set @s vt_c 4
execute if score @s vt_qactive matches 4 if score @s vt_a matches 2.. run scoreboard players set @s vt_a 1
execute if score @s vt_qactive matches 4 if score @s vt_b matches 2.. run scoreboard players set @s vt_b 1
execute if score @s vt_qactive matches 5 if score @s vt_a matches 2.. run scoreboard players set @s vt_a 1
execute if score @s vt_qactive matches 5 if score @s vt_b matches 2.. run scoreboard players set @s vt_b 1
execute if score @s vt_qactive matches 6 if score @s vt_a matches 2.. run scoreboard players set @s vt_a 1
execute if score @s vt_qactive matches 6 if score @s vt_b matches 2.. run scoreboard players set @s vt_b 1
execute if score @s vt_qactive matches 7 if score @s vt_a matches 4.. run scoreboard players set @s vt_a 3
execute if score @s vt_qactive matches 7 if score @s vt_b matches 2.. run scoreboard players set @s vt_b 1
execute if score @s vt_qactive matches 8 if score @s vt_a matches 2.. run scoreboard players set @s vt_a 1
execute if score @s vt_qactive matches 8 if score @s vt_b matches 2.. run scoreboard players set @s vt_b 1
execute if score @s vt_qactive matches 9 if score @s vt_a matches 2.. run scoreboard players set @s vt_a 1
execute if score @s vt_qactive matches 9 if score @s vt_b matches 9.. run scoreboard players set @s vt_b 8
execute if score @s vt_qactive matches 10 if score @s vt_a matches 5.. run scoreboard players set @s vt_a 4
execute if score @s vt_qactive matches 10 if score @s vt_b matches 2.. run scoreboard players set @s vt_b 1

execute if score @s vt_aux matches 1 run function village_trader:main/effect/miner
execute if score @s vt_aux matches 2 run function village_trader:main/effect/nether
execute if score @s vt_aux matches 3 run function village_trader:main/effect/end
execute if score @s vt_aux matches 4 run function village_trader:main/effect/raid
execute if score @s vt_aux matches 5 run function village_trader:main/effect/wither
execute if score @s vt_aux matches 6 run function village_trader:main/effect/sculk
function village_trader:main/effect/hard_set
