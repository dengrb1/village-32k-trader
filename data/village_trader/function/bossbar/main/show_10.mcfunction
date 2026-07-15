$bossbar set village_trader:player_$(id) name [{"text":"龙魂再临 · 水晶 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/4 | 末影龙 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 5
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 4.. if score @s vt_b matches 1.. run function village_trader:bossbar/main/complete_10 with storage village_trader:runtime bossbar
