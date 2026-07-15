execute unless score @s vt_child matches 1 run return 0
execute unless score @s vt_cstage matches 7 run return 0
execute unless score @s vt_bstage matches 1..3 run title @s actionbar {"text":"三个 Boss 印记已经完成。","color":"yellow"}
execute unless score @s vt_bstage matches 1..3 run return 0
execute if score @s vt_bactive matches 1 run title @s actionbar {"text":"当前 Boss 挑战已经激活。","color":"yellow"}
execute if score @s vt_bactive matches 1 run return 0
execute if score @s vt_bqown matches 1 run function village_trader:child/boss/reissue_challenge
execute if score @s vt_bqown matches 1 run return 1
scoreboard players set @s vt_ok 0
execute if score @s vt_bstage matches 1 run function village_trader:child/boss/buy_dragon
execute if score @s vt_bstage matches 2 run function village_trader:child/boss/buy_wither
execute if score @s vt_bstage matches 3 run function village_trader:child/boss/buy_warden
execute unless score @s vt_ok matches 1 run return 0
scoreboard players set @s vt_bqown 1
scoreboard players set @s vt_cqrep 0
title @s actionbar {"text":"挑战书已购买；必须另行提交并消耗后，Boss 击杀才会计数。","color":"green"}
