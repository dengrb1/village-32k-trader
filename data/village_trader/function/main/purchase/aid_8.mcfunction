execute unless score @s vt_stage matches 2.. run title @s actionbar {"text":"当前阶段尚未开放旅行者护符。","color":"red"}
execute unless score @s vt_stage matches 2.. run return 0
execute if entity @s[tag=village_trader.main_aux_8] run scoreboard players set @s vt_aux 8
execute if entity @s[tag=village_trader.main_aux_8] run title @s actionbar {"text":"已选中永久登记的旅行者护符。","color":"aqua"}
execute if entity @s[tag=village_trader.main_aux_8] run return 0
scoreboard players set @s vt_ok 1
execute store result score @s vt_tmp run clear @s minecraft:diamond 0
execute if score @s vt_tmp matches ..1 run scoreboard players set @s vt_ok 0
function village_trader:purchase/check_surcharge
execute if score @s vt_ok matches 1 run function village_trader:main/purchase/commit_aid_8
execute if score @s vt_ok matches 0 run title @s actionbar {"text":"2 个钻石或制裁附加费不足，未扣除物品。","color":"red"}
