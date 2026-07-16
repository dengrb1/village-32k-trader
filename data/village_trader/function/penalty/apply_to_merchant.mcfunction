# 以商人为执行者，按全局制裁等级替换所有交易的支付物。
execute if score $level vt_penalty matches 1 run data modify entity @s Offers.Recipes[].buy set value {id:"minecraft:dirt",count:16}
execute if score $level vt_penalty matches 2 run data modify entity @s Offers.Recipes[].buy set value {id:"minecraft:emerald",count:16}
execute if score $level vt_penalty matches 3.. run data modify entity @s Offers.Recipes[].buy set value {id:"minecraft:netherite_ingot",count:4}
