scoreboard players set @s vt_child 0
scoreboard players set @s vt_nvpause 0
scoreboard players set @s vt_nvsusp 0
tellraw @s [{"text":"[儿童守护线] ","color":"gold"},{"text":"检测到正在生效的主线装备，儿童线已自动暂停。请卸下主线装备后由管理员重新启用。","color":"red"}]
