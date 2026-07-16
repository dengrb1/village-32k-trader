# 3.0 通行证迁移：旧档仅补发当前可证明的最高等级通行证；既有装备保持原样。
execute if score @s vt_stage matches 2 run tag @s add village_trader.main_pass_5
execute if score @s vt_stage matches 3..5 run tag @s add village_trader.main_pass_10
execute if score @s vt_stage matches 6 run tag @s add village_trader.main_pass_20
execute if score @s vt_stage matches 7..8 run tag @s add village_trader.main_pass_32
execute if score @s vt_stage matches 9..10 run tag @s add village_trader.main_pass_64
execute if score @s vt_stage matches 11.. run tag @s add village_trader.main_pass_255
execute if entity @s[tag=village_trader.legacy_64] run tag @s add village_trader.main_pass_64
execute if entity @s[tag=village_trader.legacy_255] run tag @s add village_trader.main_pass_255

execute if score @s vt_cstage matches 1 run tag @s add village_trader.child_pass_1
execute if score @s vt_cstage matches 2 run tag @s add village_trader.child_pass_3
execute if score @s vt_cstage matches 3 run tag @s add village_trader.child_pass_5
execute if score @s vt_cstage matches 4 run tag @s add village_trader.child_pass_10
execute if score @s vt_cstage matches 5 run tag @s add village_trader.child_pass_20
execute if score @s vt_cstage matches 6..7 run tag @s add village_trader.child_pass_32
execute if score @s vt_asc matches 1.. run tag @s add village_trader.child_pass_128

scoreboard players set @s vt_good 0
scoreboard players set @s vt_buy_pending 0
scoreboard players set @s vt_cost 0
scoreboard players set @s vt_price_unit 0
scoreboard players set @s vt_equip_slot 0
scoreboard players set @s vt_d 0
execute if score @s vt_qactive matches 2 run scoreboard players operation @s vt_bredstone = @s vt_mredstone
execute if score @s vt_qactive matches 2 run scoreboard players operation @s vt_bdredstone = @s vt_mdredstone
execute if score @s vt_qactive matches 8 run scoreboard players operation @s vt_bskull = @s vt_pskull
execute if score @s vt_qactive matches 10 run scoreboard players operation @s vt_bbreath = @s vt_pbreath
scoreboard players set @s vt_cgear 0
scoreboard players set @s vt_cequip_slot 0
scoreboard players set @s vt_aux_state 0
scoreboard players set @s vt_aux_reg 0
scoreboard players set @s vt_aux_carried 0
scoreboard players enable @s vt_buy_qty
scoreboard players set @s vt_version 3
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"已迁移为装备通行证：只补发最高已解锁等级，旧装备未作改动。","color":"green"}]
