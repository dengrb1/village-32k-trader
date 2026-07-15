# 任务证和辅助用品的基础材料由业务函数另行支付；这里只扣制裁附加费。
execute if score @s vt_ok matches 1 if score $level vt_penalty matches 1 run clear @s minecraft:dirt 16
execute if score @s vt_ok matches 1 if score $level vt_penalty matches 2 run clear @s minecraft:emerald 16
execute if score @s vt_ok matches 1 if score $level vt_penalty matches 3 run clear @s minecraft:netherite_ingot 4
