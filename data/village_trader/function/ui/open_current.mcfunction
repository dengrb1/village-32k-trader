# 每位玩家只保存一个页面编号；对话框根据该编号及当前阶段即时选择，不共享会话。
execute if score @s vt_ui matches 1 run dialog show @s village_trader:ui/main_root
execute if score @s vt_ui matches 2 run dialog show @s village_trader:ui/main_equipment
execute if score @s vt_ui matches 3 run dialog show @s village_trader:ui/main_resources
execute if score @s vt_ui matches 4 run dialog show @s village_trader:ui/main_consumables
execute if score @s vt_ui matches 5 if score @s vt_stage matches 1 run dialog show @s village_trader:ui/main_quest_1
execute if score @s vt_ui matches 5 if score @s vt_stage matches 2 run dialog show @s village_trader:ui/main_quest_2
execute if score @s vt_ui matches 5 if score @s vt_stage matches 3 run dialog show @s village_trader:ui/main_quest_3
execute if score @s vt_ui matches 5 if score @s vt_stage matches 4 run dialog show @s village_trader:ui/main_quest_4
execute if score @s vt_ui matches 5 if score @s vt_stage matches 5 run dialog show @s village_trader:ui/main_quest_5
execute if score @s vt_ui matches 5 if score @s vt_stage matches 6.. run dialog show @s village_trader:ui/main_quest_6
execute if score @s vt_ui matches 6 run dialog show @s village_trader:ui/main_aids
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 0 run dialog show @s village_trader:ui/main_task_0
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 1 run dialog show @s village_trader:ui/main_task_1
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 2 run dialog show @s village_trader:ui/main_task_2
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 3 run dialog show @s village_trader:ui/main_task_3
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 4 run dialog show @s village_trader:ui/main_task_4
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 5 run dialog show @s village_trader:ui/main_task_5
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 6 run dialog show @s village_trader:ui/main_task_6
execute if score @s vt_ui matches 7 if score @s vt_qactive matches 7 run dialog show @s village_trader:ui/main_task_7
execute if score @s vt_ui matches 8 run dialog show @s village_trader:ui/main_settings
execute if score @s vt_ui matches 21 run dialog show @s village_trader:ui/child_root
execute if score @s vt_ui matches 22 run dialog show @s village_trader:ui/child_resources
execute if score @s vt_ui matches 23 run dialog show @s village_trader:ui/child_consumables
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 1 run dialog show @s village_trader:ui/child_quest_1
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 2 run dialog show @s village_trader:ui/child_quest_2
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 3 run dialog show @s village_trader:ui/child_quest_3
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 4 run dialog show @s village_trader:ui/child_quest_4
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 5 run dialog show @s village_trader:ui/child_quest_5
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 6 run dialog show @s village_trader:ui/child_quest_6
execute if score @s vt_ui matches 24 if score @s vt_cstage matches 7.. run dialog show @s village_trader:ui/child_quest_7
execute if score @s vt_ui matches 25 run dialog show @s village_trader:ui/child_auxiliary
execute if score @s vt_ui matches 26 run function village_trader:ui/refresh_task_card
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 1 run dialog show @s village_trader:ui/child_task_1
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 2 run dialog show @s village_trader:ui/child_task_2
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 3 run dialog show @s village_trader:ui/child_task_3
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 4 run dialog show @s village_trader:ui/child_task_4
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 5 run dialog show @s village_trader:ui/child_task_5
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 6 run dialog show @s village_trader:ui/child_task_6
execute if score @s vt_ui matches 26 if score @s vt_cstage matches 7.. run dialog show @s village_trader:ui/child_task_7
execute if score @s vt_ui matches 27 run dialog show @s village_trader:ui/child_boss
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 1 run dialog show @s village_trader:ui/child_tutorial_1
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 2 run dialog show @s village_trader:ui/child_tutorial_2
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 3 run dialog show @s village_trader:ui/child_tutorial_3
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 4 run dialog show @s village_trader:ui/child_tutorial_4
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 5 run dialog show @s village_trader:ui/child_tutorial_5
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 6 run dialog show @s village_trader:ui/child_tutorial_6
execute if score @s vt_ui matches 28 if score @s vt_cstage matches 7.. run dialog show @s village_trader:ui/child_tutorial_7
execute if score @s vt_ui matches 29 run dialog show @s village_trader:ui/child_status
execute if score @s vt_ui matches 30 run dialog show @s village_trader:ui/child_equipment
