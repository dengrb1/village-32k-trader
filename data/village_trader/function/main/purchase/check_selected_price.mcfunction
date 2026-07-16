# 先完整检查批量总价，成功前不扣除任何物品。
scoreboard players set @s vt_price_unit 0
execute if score $level vt_penalty matches 0 run scoreboard players set @s vt_price_unit 1
execute if score $level vt_penalty matches 1 run scoreboard players set @s vt_price_unit 16
execute if score $level vt_penalty matches 2 run scoreboard players set @s vt_price_unit 16
execute if score $level vt_penalty matches 3 run scoreboard players set @s vt_price_unit 4
execute unless score $level vt_penalty matches 0..3 run scoreboard players set @s vt_ok 0
scoreboard players operation @s vt_cost = @s vt_buy_pending
scoreboard players operation @s vt_cost *= @s vt_price_unit
scoreboard players set @s vt_tmp 0
execute if score $level vt_penalty matches 0 store result score @s vt_tmp run clear @s minecraft:dirt 0
execute if score $level vt_penalty matches 1 store result score @s vt_tmp run clear @s minecraft:dirt 0
execute if score $level vt_penalty matches 2 store result score @s vt_tmp run clear @s minecraft:emerald 0
execute if score $level vt_penalty matches 3 store result score @s vt_tmp run clear @s minecraft:netherite_ingot 0
execute unless score @s vt_tmp >= @s vt_cost run scoreboard players set @s vt_ok 0
