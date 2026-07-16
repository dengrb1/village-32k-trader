execute if score $level vt_penalty matches 0 run data modify storage village_trader:buy currency set value "minecraft:dirt"
execute if score $level vt_penalty matches 1 run data modify storage village_trader:buy currency set value "minecraft:dirt"
execute if score $level vt_penalty matches 2 run data modify storage village_trader:buy currency set value "minecraft:emerald"
execute if score $level vt_penalty matches 3 run data modify storage village_trader:buy currency set value "minecraft:netherite_ingot"
execute store result storage village_trader:buy count int 1 run scoreboard players get @s vt_cost
function village_trader:main/purchase/pay_selected_price_macro with storage village_trader:buy
