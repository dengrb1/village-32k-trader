# 钥匙物品本身不携带可转让的权限；权限始终登记在领取者的 vt_portable 中。
tag @s remove village_trader.has_portable_key
execute if items entity @s inventory.* minecraft:warped_fungus_on_a_stick[minecraft:custom_data~{village_trader_portable_key:1b}] run tag @s add village_trader.has_portable_key
execute if items entity @s weapon.offhand minecraft:warped_fungus_on_a_stick[minecraft:custom_data~{village_trader_portable_key:1b}] run tag @s add village_trader.has_portable_key
