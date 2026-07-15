advancement revoke @s only village_trader:child/kill_warden
scoreboard players set @s vt_ok 0
execute if score @s vt_child matches 1 if score @s vt_cstage matches 7 if score @s vt_bstage matches 3 if score @s vt_bactive matches 1 run scoreboard players set @s vt_ok 1
execute unless score @s vt_ok matches 1 run return 0
tag @s add village_trader.mark_warden
scoreboard players set @s vt_bactive 0
scoreboard players set @s vt_bqown 0
scoreboard players set @s vt_cqrep 0
scoreboard players set @s vt_bstage 4
tellraw @s {"text":"监守者番外完成：永久获得“幽匿之印”；升格核心已开放。","color":"dark_aqua","bold":true}
