advancement revoke @s only village_trader:child/kill_wither
scoreboard players set @s vt_ok 0
execute if score @s vt_child matches 1 if score @s vt_cstage matches 7 if score @s vt_bstage matches 2 if score @s vt_bactive matches 1 run scoreboard players set @s vt_ok 1
execute unless score @s vt_ok matches 1 run return 0
advancement grant @s only village_trader:achievements/guardian_05
tag @s add village_trader.mark_wither
scoreboard players set @s vt_bactive 0
scoreboard players set @s vt_bqown 0
scoreboard players set @s vt_cqrep 0
scoreboard players set @s vt_bstage 3
tellraw @s {"text":"凋灵番外完成：永久获得“凋灵之印”。","color":"dark_gray","bold":true}
