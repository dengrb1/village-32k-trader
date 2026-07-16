execute if score @s vt_tmp matches 0 run title @s actionbar {"text":"[村庄商人] 辅助用品状态变化：当前未生效（需已登记、已选中、随身携带且满足场景）。","color":"yellow"}
execute if score @s vt_tmp matches 1.. run title @s actionbar [{"text":"[村庄商人] 辅助用品状态变化：已生效（编号 ","color":"green"},{"score":{"name":"@s","objective":"vt_tmp"},"color":"aqua"},{"text":"）。","color":"green"}]
