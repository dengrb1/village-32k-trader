# 只读检查当前儿童任务牌，用于在对话框中分别展示任务牌状态。
scoreboard players set @s vt_ui_card 0
execute if score @s vt_cstage matches 1 store result score @s vt_ui_card run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:1}] 0
execute if score @s vt_cstage matches 2 store result score @s vt_ui_card run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:2}] 0
execute if score @s vt_cstage matches 3 store result score @s vt_ui_card run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:3}] 0
execute if score @s vt_cstage matches 4 store result score @s vt_ui_card run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:4}] 0
execute if score @s vt_cstage matches 5 store result score @s vt_ui_card run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:5}] 0
execute if score @s vt_cstage matches 6 store result score @s vt_ui_card run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:6}] 0
