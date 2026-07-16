# 儿童线暂停时持续移动统计基线，保留已取得进度并忽略暂停期间的挖掘/烧制。
execute if score @s vt_child matches 0 if score @s vt_cactive matches 1 if score @s vt_cstage matches 2 run scoreboard players operation @s vt_cbcob = @s vt_mcob
execute if score @s vt_child matches 0 if score @s vt_cactive matches 1 if score @s vt_cstage matches 2 run scoreboard players operation @s vt_cbcob -= @s vt_ca
execute if score @s vt_child matches 0 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 if score @s vt_cb matches 0 run scoreboard players operation @s vt_cbdia = @s vt_mdia
execute if score @s vt_child matches 0 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 if score @s vt_cb matches 0 run scoreboard players operation @s vt_cbddia = @s vt_mddia

execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 1 store result score @s vt_tmp run clear @s #minecraft:logs 0
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 1 if score @s vt_tmp matches 4.. run scoreboard players set @s vt_ca 1
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 1 store result score @s vt_tmp run clear @s minecraft:crafting_table 0
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 1 if score @s vt_tmp matches 1.. run scoreboard players set @s vt_cb 1

execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 2 run scoreboard players operation @s vt_ca = @s vt_mcob
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 2 run scoreboard players operation @s vt_ca -= @s vt_cbcob
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 2 if score @s vt_ca matches ..-1 run scoreboard players set @s vt_ca 0
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 2 if score @s vt_ca matches 17.. run scoreboard players set @s vt_ca 16
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 4 if items entity @s weapon.offhand minecraft:shield run scoreboard players set @s vt_ca 1

execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 store result score @s vt_tmp run clear @s minecraft:emerald 0
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 if score @s vt_tmp matches 4.. run scoreboard players set @s vt_cc 1
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 run scoreboard players operation @s vt_tmp = @s vt_mdia
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 run scoreboard players operation @s vt_tmp -= @s vt_cbdia
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 run scoreboard players operation @s vt_ok = @s vt_mddia
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 run scoreboard players operation @s vt_ok -= @s vt_cbddia
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 run scoreboard players operation @s vt_tmp += @s vt_ok
execute if score @s vt_child matches 1 if score @s vt_cactive matches 1 if score @s vt_cstage matches 5 if score @s vt_tmp matches 1.. run scoreboard players set @s vt_cb 1

# 主线装备在儿童模式中会自动暂停儿童线，防止 255/32767 属性绕过儿童安全上限。
execute if score @s vt_child matches 1 if items entity @s armor.* #village_trader:main_equipment[minecraft:custom_data~{kind:"main_equipment"}] run function village_trader:child/block_main_equipment
execute if score @s vt_child matches 1 if items entity @s weapon.mainhand #village_trader:main_equipment[minecraft:custom_data~{kind:"main_equipment"}] run function village_trader:child/block_main_equipment
execute if score @s vt_child matches 1 if items entity @s weapon.offhand #village_trader:main_equipment[minecraft:custom_data~{kind:"main_equipment"}] run function village_trader:child/block_main_equipment
