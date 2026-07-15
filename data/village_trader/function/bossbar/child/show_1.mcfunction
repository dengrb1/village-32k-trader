$bossbar set village_trader:player_$(id) name [{"text":"木工启程 · 原木 "},{"score":{"name":"@s","objective":"vt_ca"}},{"text":"/1 | 工作台 "},{"score":{"name":"@s","objective":"vt_cb"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 2
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color blue
execute if score @s vt_ca matches 1.. if score @s vt_cb matches 1.. run function village_trader:bossbar/child/complete_1 with storage village_trader:runtime bossbar
