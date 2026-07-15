# 当前 Dialog 的动作关闭页面后，先显示操作反馈，再恢复到同一页。
scoreboard players operation @s vt_ui_pending = @s vt_ui
scoreboard players set @s vt_ui_delay 30
