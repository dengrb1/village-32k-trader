# 商人仅作为可击杀的个人商店入口，不再保存共享商品列表。
data modify entity @s Offers set value {Recipes:[]}
data modify entity @s VillagerData.profession set value "minecraft:none"
data modify entity @s VillagerData.level set value 1
data modify entity @s Xp set value 0
data modify entity @s CustomName set value '{"text":"「终焉黑市」成长商店","color":"dark_purple","bold":true}'
tag @s remove village_trader.new
