# 称号只用于状态与菜单展示，不改动玩家聊天名。
scoreboard players set @s vt_title 0
execute if score @s vt_ach_total matches 5.. run scoreboard players set @s vt_title 1
execute if score @s vt_ach_total matches 15.. run scoreboard players set @s vt_title 2
execute if score @s vt_ach_total matches 25.. run scoreboard players set @s vt_title 3
execute if score @s vt_ach_total matches 35.. run scoreboard players set @s vt_title 4
execute if score @s vt_ach_total matches 40.. run scoreboard players set @s vt_title 5
