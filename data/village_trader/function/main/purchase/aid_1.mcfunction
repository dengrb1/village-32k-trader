execute unless score @s vt_stage matches 1.. run title @s actionbar [{"text":"[村庄商人] 当前阶段尚未开放「矿工补给包」。","color":"red"}]
execute unless score @s vt_stage matches 1.. run return 0
execute if entity @s[tag=village_trader.main_aux_1] run scoreboard players set @s vt_aux 1
execute if entity @s[tag=village_trader.main_aux_1] run title @s actionbar [{"text":"[村庄商人] 已选择永久登记的「矿工补给包」。","color":"aqua"}]
execute if entity @s[tag=village_trader.main_aux_1] run return 0
scoreboard players set @s vt_ok 1
execute store result score @s vt_tmp run clear @s minecraft:emerald 0
execute if score @s vt_tmp matches ..7 run scoreboard players set @s vt_ok 0
function village_trader:purchase/check_surcharge
execute if score $level vt_penalty matches 2 store result score @s vt_tmp run clear @s minecraft:emerald 0
execute if score $level vt_penalty matches 2 if score @s vt_tmp matches ..23 run scoreboard players set @s vt_ok 0
execute if score @s vt_ok matches 1 run function village_trader:main/purchase/commit_aid_1
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 8 个绿宝石或制裁附加费不足，未扣除物品。","color":"red"}]

