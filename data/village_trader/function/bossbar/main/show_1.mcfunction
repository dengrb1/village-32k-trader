$bossbar set village_trader:player_$(id) name [{"text":"定居启程 · 工作台 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/1 | 睡床 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 2
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 1.. if score @s vt_b matches 1.. run function village_trader:bossbar/main/complete_1 with storage village_trader:runtime bossbar
