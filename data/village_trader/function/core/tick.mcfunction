# 初始化新玩家、处理个人菜单请求和购买动作，再续期各业务线的逐刻逻辑。
execute as @a unless score @s vt_init matches 1.. run function village_trader:core/init_player
execute as @a run function village_trader:portable/update
execute as @a[scores={vt_key_cd=1..}] run scoreboard players remove @s vt_key_cd 1
execute as @a[scores={vt_menu=1..}] at @s run function village_trader:core/open_request
execute as @a[scores={vt_action=1..}] at @s run function village_trader:core/action
execute as @a at @s run function village_trader:main/tick_player
execute as @a at @s run function village_trader:child/tick_player
