execute unless score @s vt_stage matches 3.. run title @s actionbar [{"text":"[村庄商人] 当前阶段尚未开放「下界护符」。","color":"red"}]
execute unless score @s vt_stage matches 3.. run return 0
execute if entity @s[tag=village_trader.main_aux_2] run scoreboard players set @s vt_aux 2
execute if entity @s[tag=village_trader.main_aux_2] run title @s actionbar [{"text":"[村庄商人] 已选择永久登记的「下界护符」。","color":"aqua"}]
execute if entity @s[tag=village_trader.main_aux_2] run return 0
scoreboard players set @s vt_ok 1
execute store result score @s vt_tmp run clear @s minecraft:diamond 0
execute if score @s vt_tmp matches ..3 run scoreboard players set @s vt_ok 0
function village_trader:purchase/check_surcharge
execute if score @s vt_ok matches 1 run function village_trader:main/purchase/commit_aid_2
execute if score @s vt_ok matches 0 run title @s actionbar [{"text":"[村庄商人] 4 个钻石或制裁附加费不足，未扣除物品。","color":"red"}]

