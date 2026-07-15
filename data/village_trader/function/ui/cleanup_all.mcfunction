# 升级时只清理旧聊天菜单的临时状态和已显示的会话，不触及成长、任务与制裁记录。
dialog clear @a
scoreboard players set @a vt_menu 0
scoreboard players set @a vt_action 0
scoreboard players set @a vt_ui 0
scoreboard players set @a vt_ui_last 0
scoreboard players set @a vt_ui_card 0
scoreboard players enable @a vt_menu
scoreboard players enable @a vt_action
