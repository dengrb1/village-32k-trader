# 每位玩家只保存一个页面编号；对话框根据该编号及当前阶段即时选择，不共享会话。
execute if score @s vt_ui matches 1 run dialog show @s village_trader:main_root
execute if score @s vt_ui matches 2 run dialog show @s village_trader:main_equipment_pass_select
execute if score @s vt_ui matches 3 run dialog show @s village_trader:main_resources_catalog
execute if score @s vt_ui matches 4 run dialog show @s village_trader:main_consumables_catalog
execute if score @s vt_ui matches 15 run dialog show @s village_trader:main_buy_quantity
execute if score @s vt_ui matches 16 run dialog show @s village_trader:main_equipment_pass
execute if score @s vt_ui matches 17 run dialog show @s village_trader:main_equipment_pass_armor
execute if score @s vt_ui matches 18 run dialog show @s village_trader:main_equipment_pass_melee
execute if score @s vt_ui matches 19 run dialog show @s village_trader:main_equipment_pass_tools
execute if score @s vt_ui matches 20 run dialog show @s village_trader:main_equipment_pass_ranged
execute if score @s vt_ui matches 5 if score @s vt_stage matches 1 run dialog show @s village_trader:main_quest_1
execute if score @s vt_ui matches 5 if score @s vt_stage matches 2 run dialog show @s village_trader:main_quest_2
execute if score @s vt_ui matches 5 if score @s vt_stage matches 3 run dialog show @s village_trader:main_quest_3
execute if score @s vt_ui matches 5 if score @s vt_stage matches 4 run dialog show @s village_trader:main_quest_4
execute if score @s vt_ui matches 5 if score @s vt_stage matches 5 run dialog show @s village_trader:main_quest_5
execute if score @s vt_ui matches 5 if score @s vt_stage matches 6 run dialog show @s village_trader:main_quest_6
execute if score @s vt_ui matches 5 if score @s vt_stage matches 7 run dialog show @s village_trader:main_quest_7
execute if score @s vt_ui matches 5 if score @s vt_stage matches 8 run dialog show @s village_trader:main_quest_8
execute if score @s vt_ui matches 5 if score @s vt_stage matches 9 run dialog show @s village_trader:main_quest_9
execute if score @s vt_ui matches 5 if score @s vt_stage matches 10 run dialog show @s village_trader:main_quest_10
execute if score @s vt_ui matches 5 if score @s vt_stage matches 11.. run dialog show @s village_trader:main_quest_11
execute if score @s vt_ui matches 6 run dialog show @s village_trader:main_aids_catalog
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 1 run dialog show @s village_trader:main_task_0_s1
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 2 run dialog show @s village_trader:main_task_0_s2
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 3 run dialog show @s village_trader:main_task_0_s3
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 4 run dialog show @s village_trader:main_task_0_s4
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 5 run dialog show @s village_trader:main_task_0_s5
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 6 run dialog show @s village_trader:main_task_0_s6
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 7 run dialog show @s village_trader:main_task_0_s7
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 8 run dialog show @s village_trader:main_task_0_s8
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 9 run dialog show @s village_trader:main_task_0_s9
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 if score @s vt_stage matches 10 run dialog show @s village_trader:main_task_0_s10
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 1 run dialog show @s village_trader:main_task_1
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 2 run dialog show @s village_trader:main_task_2
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 3 run dialog show @s village_trader:main_task_3
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 4 run dialog show @s village_trader:main_task_4
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 5 run dialog show @s village_trader:main_task_5
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 6 run dialog show @s village_trader:main_task_6
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 7 run dialog show @s village_trader:main_task_7
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 8 run dialog show @s village_trader:main_task_8
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 9 run dialog show @s village_trader:main_task_9
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 10 run dialog show @s village_trader:main_task_10
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 11 run dialog show @s village_trader:main_task_11
execute if score @s vt_ui matches 8 if score @s vt_stage matches 1 run dialog show @s village_trader:main_settings_s1
execute if score @s vt_ui matches 8 if score @s vt_stage matches 2 run dialog show @s village_trader:main_settings_s2
execute if score @s vt_ui matches 8 if score @s vt_stage matches 3 run dialog show @s village_trader:main_settings_s3
execute if score @s vt_ui matches 8 if score @s vt_stage matches 4 run dialog show @s village_trader:main_settings_s4
execute if score @s vt_ui matches 8 if score @s vt_stage matches 5 run dialog show @s village_trader:main_settings_s5
execute if score @s vt_ui matches 8 if score @s vt_stage matches 6..10 run dialog show @s village_trader:main_settings_s6
execute if score @s vt_ui matches 8 if score @s vt_stage matches 11.. run dialog show @s village_trader:main_settings_s6_final
execute if score @s vt_ui matches 9 run dialog show @s village_trader:achievements
execute if score @s vt_ui matches 10 run dialog show @s village_trader:achievements_story
execute if score @s vt_ui matches 11 run dialog show @s village_trader:achievements_explore
execute if score @s vt_ui matches 12 run dialog show @s village_trader:achievements_combat
execute if score @s vt_ui matches 13 run dialog show @s village_trader:achievements_trade
execute if score @s vt_ui matches 14 run dialog show @s village_trader:achievements_guardian
execute if score @s vt_ui matches 21 run dialog show @s village_trader:child_root
execute if score @s vt_ui matches 22 if score @s vt_cstage matches 1 run dialog show @s village_trader:child_resources_s1
execute if score @s vt_ui matches 22 if score @s vt_cstage matches 2 run dialog show @s village_trader:child_resources_s2
execute if score @s vt_ui matches 22 if score @s vt_cstage matches 3 run dialog show @s village_trader:child_resources_s3
execute if score @s vt_ui matches 22 if score @s vt_cstage matches 4 run dialog show @s village_trader:child_resources_s4
execute if score @s vt_ui matches 22 if score @s vt_cstage matches 5 run dialog show @s village_trader:child_resources_s5
execute if score @s vt_ui matches 22 if score @s vt_cstage matches 6 run dialog show @s village_trader:child_resources_s6
execute if score @s vt_ui matches 22 if score @s vt_cstage matches 7.. run dialog show @s village_trader:child_resources_s7
execute if score @s vt_ui matches 23 if score @s vt_cstage matches 1 run dialog show @s village_trader:child_consumables_s1
execute if score @s vt_ui matches 23 if score @s vt_cstage matches 2 run dialog show @s village_trader:child_consumables_s2
execute if score @s vt_ui matches 23 if score @s vt_cstage matches 3 run dialog show @s village_trader:child_consumables_s3
execute if score @s vt_ui matches 23 if score @s vt_cstage matches 4 run dialog show @s village_trader:child_consumables_s4
execute if score @s vt_ui matches 23 if score @s vt_cstage matches 5 run dialog show @s village_trader:child_consumables_s5
execute if score @s vt_ui matches 23 if score @s vt_cstage matches 6 run dialog show @s village_trader:child_consumables_s6
execute if score @s vt_ui matches 23 if score @s vt_cstage matches 7.. run dialog show @s village_trader:child_consumables_s7
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 1 run dialog show @s village_trader:child_quest_1
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 2 run dialog show @s village_trader:child_quest_2
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 3 run dialog show @s village_trader:child_quest_3
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 4 run dialog show @s village_trader:child_quest_4
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 5 run dialog show @s village_trader:child_quest_5
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 6 run dialog show @s village_trader:child_quest_6
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 7.. run dialog show @s village_trader:child_quest_7
execute if score @s vt_ui matches 25 if score @s vt_cstage matches 1 run dialog show @s village_trader:child_auxiliary_s1
execute if score @s vt_ui matches 25 if score @s vt_cstage matches 2 run dialog show @s village_trader:child_auxiliary_s2
execute if score @s vt_ui matches 25 if score @s vt_cstage matches 3 run dialog show @s village_trader:child_auxiliary_s3
execute if score @s vt_ui matches 25 if score @s vt_cstage matches 4 run dialog show @s village_trader:child_auxiliary_s4
execute if score @s vt_ui matches 25 if score @s vt_cstage matches 5 run dialog show @s village_trader:child_auxiliary_s5
execute if score @s vt_ui matches 25 if score @s vt_cstage matches 6 run dialog show @s village_trader:child_auxiliary_s6
execute if score @s vt_ui matches 25 if score @s vt_cstage matches 7.. run dialog show @s village_trader:child_auxiliary_s7
execute if score @s vt_ui matches 26 run function village_trader:ui/refresh_task_card
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 1 run dialog show @s village_trader:child_task_1
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 2 run dialog show @s village_trader:child_task_2
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 3 run dialog show @s village_trader:child_task_3
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 4 run dialog show @s village_trader:child_task_4
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 5 run dialog show @s village_trader:child_task_5
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 6 run dialog show @s village_trader:child_task_6
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 7.. run dialog show @s village_trader:child_task_7
execute if score @s vt_ui matches 27 unless score @s vt_cstage matches 7.. run dialog show @s village_trader:child_boss_locked
execute if score @s vt_ui matches 27 if score @s vt_cstage matches 7.. if score @s vt_bstage matches 1 run dialog show @s village_trader:child_boss_s1
execute if score @s vt_ui matches 27 if score @s vt_cstage matches 7.. if score @s vt_bstage matches 2 run dialog show @s village_trader:child_boss_s2
execute if score @s vt_ui matches 27 if score @s vt_cstage matches 7.. if score @s vt_bstage matches 3 run dialog show @s village_trader:child_boss_s3
execute if score @s vt_ui matches 27 if score @s vt_cstage matches 7.. if score @s vt_bstage matches 4 if score @s vt_asc matches 1 run dialog show @s village_trader:child_boss_s4_asc
execute if score @s vt_ui matches 27 if score @s vt_cstage matches 7.. if score @s vt_bstage matches 4 unless score @s vt_asc matches 1 run dialog show @s village_trader:child_boss_s4
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 1 run dialog show @s village_trader:child_tutorial_1
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 2 run dialog show @s village_trader:child_tutorial_2
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 3 run dialog show @s village_trader:child_tutorial_3
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 4 run dialog show @s village_trader:child_tutorial_4
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 5 run dialog show @s village_trader:child_tutorial_5
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 6 run dialog show @s village_trader:child_tutorial_6
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 7.. run dialog show @s village_trader:child_tutorial_7
execute if score @s vt_ui matches 29 run dialog show @s village_trader:child_status
execute if score @s vt_ui matches 30 if score @s vt_cstage matches 1 run dialog show @s village_trader:child_equipment_s1
execute if score @s vt_ui matches 30 if score @s vt_cstage matches 2 run dialog show @s village_trader:child_equipment_s2
execute if score @s vt_ui matches 30 if score @s vt_cstage matches 3 run dialog show @s village_trader:child_equipment_s3
execute if score @s vt_ui matches 30 if score @s vt_cstage matches 4 run dialog show @s village_trader:child_equipment_s4
execute if score @s vt_ui matches 30 if score @s vt_cstage matches 5 run dialog show @s village_trader:child_equipment_s5
execute if score @s vt_ui matches 30 if score @s vt_cstage matches 6 run dialog show @s village_trader:child_equipment_s6
execute if score @s vt_ui matches 30 if score @s vt_cstage matches 7.. unless score @s vt_asc matches 1 run dialog show @s village_trader:child_equipment_s7
execute if score @s vt_ui matches 30 if score @s vt_cstage matches 7.. if score @s vt_asc matches 1 run dialog show @s village_trader:child_equipment_s7_asc
execute if score @s vt_ui matches 31 run dialog show @s village_trader:child_equipment_pass
execute if score @s vt_ui matches 32 run dialog show @s village_trader:child_equipment_pass_armor
execute if score @s vt_ui matches 33 run dialog show @s village_trader:child_equipment_pass_melee
execute if score @s vt_ui matches 34 run dialog show @s village_trader:child_equipment_pass_tools
execute if score @s vt_ui matches 35 run dialog show @s village_trader:child_equipment_pass_ranged
