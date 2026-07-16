$bossbar set village_trader:player_$(id) name [{"text":"主线","color":"yellow"},{"text":" · 阶段 "},{"score":{"name":"@s","objective":"vt_stage"}},{"text":" · 购买并激活任务牌"}]
$bossbar set village_trader:player_$(id) max 1
$bossbar set village_trader:player_$(id) value 0
$bossbar set village_trader:player_$(id) color yellow
execute if score @s vt_diff matches 1 run function village_trader:bossbar/main/idle_hard with storage village_trader:runtime bossbar
