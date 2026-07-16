execute if score @s vt_ach_view matches 1 run function village_trader:achievement/claim_story
execute if score @s vt_ach_view matches 2 run function village_trader:achievement/claim_explore
execute if score @s vt_ach_view matches 3 run function village_trader:achievement/claim_combat
execute if score @s vt_ach_view matches 4 run function village_trader:achievement/claim_trade
execute if score @s vt_ach_view matches 5 run function village_trader:achievement/claim_guardian
execute unless score @s vt_ach_view matches 1..5 run title @s actionbar [{"text":"[成就] 请先选择一个成就分类。","color":"yellow"}]
