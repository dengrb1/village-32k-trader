# 调用方先把 vt_ok 设为 1；本函数只在余额不足时置 0，不扣款、不提示。
scoreboard players set @s vt_tmp 0
execute unless score $level vt_penalty matches 0..3 run scoreboard players set @s vt_ok 0
execute if score $level vt_penalty matches 0 store result score @s vt_tmp run clear @s minecraft:dirt 0
execute if score $level vt_penalty matches 0 if score @s vt_tmp matches ..0 run scoreboard players set @s vt_ok 0
execute if score $level vt_penalty matches 1 store result score @s vt_tmp run clear @s minecraft:dirt 0
execute if score $level vt_penalty matches 1 if score @s vt_tmp matches ..15 run scoreboard players set @s vt_ok 0
execute if score $level vt_penalty matches 2 store result score @s vt_tmp run clear @s minecraft:emerald 0
execute if score $level vt_penalty matches 2 if score @s vt_tmp matches ..15 run scoreboard players set @s vt_ok 0
execute if score $level vt_penalty matches 3 store result score @s vt_tmp run clear @s minecraft:netherite_ingot 0
execute if score $level vt_penalty matches 3 if score @s vt_tmp matches ..3 run scoreboard players set @s vt_ok 0
