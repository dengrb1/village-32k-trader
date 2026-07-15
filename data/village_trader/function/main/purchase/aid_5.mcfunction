execute unless score @s vt_stage matches 8.. run title @s actionbar [{"text":"[村庄商人] 当前阶段尚未开放「凋灵净化符」。","color":"red"}]
execute unless score @s vt_stage matches 8.. run return 0
execute if entity @s[tag=village_trader.main_aux_5] run scoreboard players set @s vt_aux 5
execute if entity @s[tag=village_trader.main_aux_5] run title @s actionbar [{"text":"[村庄商人] 已选择永久登记的「凋灵净化符」。","color":"aqua"}]
execute if entity @s[tag=village_trader.main_aux_5] run return 0
scoreboard players set @s vt_ok 1
execute store result score @s vt_tmp run clear @s minecraft:diamond_block 0
execute if score @s vt_tmp matches ..0 run scoreboard players set @s vt_ok 0
function village_trader:purchase/check_surcharge
execute if score @s vt_ok matches 1 run function village_trader:main/purchase/commit_aid_5
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 1 个钻石块或制裁附加费不足，未扣除物品。","color":"red"}]

