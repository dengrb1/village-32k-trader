# 初始化新玩家、处理个人菜单请求和购买动作，再续期各业务线的逐刻逻辑。
execute as @a unless score @s vt_init matches 1.. run function village_trader:core/init_player
execute as @a if score @s vt_init matches 1.. unless score @s vt_version matches 2.. run function village_trader:migration/main_v2
execute as @a if score @s vt_init matches 1.. unless score @s vt_version matches 3.. run function village_trader:migration/main_v3
execute as @a run function village_trader:portable/update
execute as @a[scores={vt_progress=1..}] run function village_trader:main/progress/open
execute as @a[scores={vt_progress=1..}] run scoreboard players set @s vt_progress 0
scoreboard players enable @a vt_progress
execute as @a[scores={vt_buy_qty=1..64}] run scoreboard players operation @s vt_buy_pending = @s vt_buy_qty
execute as @a[scores={vt_buy_qty=1..64}] run scoreboard players set @s vt_action 190
execute as @a[scores={vt_buy_qty=65..}] run title @s actionbar {"text":"购买包数必须在 1 到 64 之间。","color":"red"}
execute as @a[scores={vt_buy_qty=65..}] run scoreboard players set @s vt_buy_qty 0
execute as @a[scores={vt_buy_qty=1..64}] run scoreboard players set @s vt_buy_qty 0
scoreboard players enable @a vt_buy_qty
execute as @a[scores={vt_key_cd=1..}] run scoreboard players remove @s vt_key_cd 1
execute as @a[scores={vt_menu=1..}] at @s run function village_trader:core/open_request
execute as @a[scores={vt_action=1..}] at @s run function village_trader:core/action
execute as @a[scores={vt_ui_delay=1..}] run scoreboard players remove @s vt_ui_delay 1
execute as @a[scores={vt_ui_delay=0,vt_ui_pending=1..}] run function village_trader:ui/reopen_pending
execute as @a at @s run function village_trader:main/tick_player
execute as @a at @s run function village_trader:child/tick_player
