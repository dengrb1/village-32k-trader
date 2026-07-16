# 业务函数完成全部检查后调用；只有 vt_ok=1 时才支付当前制裁商品价。
execute if score @s vt_ok matches 1 if score $level vt_penalty matches 0 run clear @s minecraft:dirt 1
execute if score @s vt_ok matches 1 if score $level vt_penalty matches 1 run clear @s minecraft:dirt 16
execute if score @s vt_ok matches 1 if score $level vt_penalty matches 2 run clear @s minecraft:emerald 16
execute if score @s vt_ok matches 1 if score $level vt_penalty matches 3 run clear @s minecraft:netherite_ingot 4
