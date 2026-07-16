scoreboard players set @s vt_ok 1
execute store result score @s vt_tmp run clear @s minecraft:emerald 0
execute if score @s vt_tmp matches ..15 run scoreboard players set @s vt_ok 0
execute store result score @s vt_tmp run clear @s minecraft:ominous_bottle 0
execute if score @s vt_tmp matches ..0 run scoreboard players set @s vt_ok 0
function village_trader:purchase/check_surcharge
execute if score $level vt_penalty matches 2 store result score @s vt_tmp run clear @s minecraft:emerald 0
execute if score $level vt_penalty matches 2 if score @s vt_tmp matches ..31 run scoreboard players set @s vt_ok 0
execute if score @s vt_ok matches 1 run function village_trader:main/task/commit_6
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 材料或制裁附加费不足，未扣除任何物品。","color":"red"}]
