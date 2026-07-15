# 仅对没有初始化记录的玩家执行；之后 /reload 不会重置个人状态。
tag @s remove village_trader.main_aux_1
tag @s remove village_trader.main_aux_2
tag @s remove village_trader.main_aux_3
tag @s remove village_trader.main_aux_4
tag @s remove village_trader.main_aux_5
tag @s remove village_trader.main_aux_6
tag @s remove village_trader.child_aux_1
tag @s remove village_trader.child_aux_2
tag @s remove village_trader.child_aux_3
tag @s remove village_trader.child_aux_4
tag @s remove village_trader.child_aux_5
tag @s remove village_trader.child_aux_6
tag @s remove village_trader.child_aux_7
tag @s remove village_trader.child_aux_8
tag @s remove village_trader.child_aux_9
tag @s remove village_trader.mark_dragon
tag @s remove village_trader.mark_wither
tag @s remove village_trader.mark_warden
tag @s remove village_trader.main_set
tag @s remove village_trader.child_set
tag @s remove village_trader.asc_set
tag @s remove village_trader.effect_target
scoreboard players set @s vt_stage 1
scoreboard players set @s vt_diff 0
scoreboard players set @s vt_gear 1
scoreboard players set @s vt_qown 0
scoreboard players set @s vt_qrep 0
scoreboard players set @s vt_qactive 0
scoreboard players set @s vt_a 0
scoreboard players set @s vt_b 0
scoreboard players set @s vt_c 0
scoreboard players set @s vt_child 0
scoreboard players set @s vt_cstage 1
scoreboard players set @s vt_cqown 0
scoreboard players set @s vt_cqrep 0
scoreboard players set @s vt_cactive 0
scoreboard players set @s vt_ca 0
scoreboard players set @s vt_cb 0
scoreboard players set @s vt_cc 0
scoreboard players set @s vt_bstage 1
scoreboard players set @s vt_bqown 0
scoreboard players set @s vt_bactive 0
scoreboard players set @s vt_asc 0
scoreboard players set @s vt_asckey 0
scoreboard players set @s vt_aux 0
scoreboard players set @s vt_caux 0
scoreboard players set @s vt_nvpause 0
scoreboard players set @s vt_nvsusp 0
scoreboard players set @s vt_healcd 0
scoreboard players set @s vt_tmp 0
scoreboard players set @s vt_ok 0
scoreboard players set @s vt_mdia 0
scoreboard players set @s vt_mddia 0
scoreboard players set @s vt_mdebris 0
scoreboard players set @s vt_mcob 0
scoreboard players set @s vt_ptotem 0
scoreboard players set @s vt_bdia 0
scoreboard players set @s vt_bddia 0
scoreboard players set @s vt_bdebris 0
scoreboard players set @s vt_cbdia 0
scoreboard players set @s vt_cbddia 0
scoreboard players set @s vt_cbcob 0
scoreboard players set @s vt_btotem 0
scoreboard players set @s vt_menu 0
scoreboard players set @s vt_action 0
scoreboard players set @s vt_ui 0
scoreboard players set @s vt_ui_last 0
scoreboard players set @s vt_ui_card 0
scoreboard players set @s vt_portable 0
scoreboard players set @s vt_key_cd 0
scoreboard players enable @s vt_menu
scoreboard players enable @s vt_action
scoreboard players set @s vt_init 1
