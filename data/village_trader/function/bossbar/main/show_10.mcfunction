$bossbar set village_trader:player_$(id) name [{"text":"龙魂再临 · 水晶,vt_a,4"},{"text":" 水晶 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/4"},{"text":" | 末影龙 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/1"},{"text":" | 龙息 "},{"score":{"name":"@s","objective":"vt_c"}},{"text":"/4"}]
$bossbar set village_trader:player_$(id) max 9
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 4.. if score @s vt_b matches 1.. if score @s vt_c matches 4.. run function village_trader:bossbar/main/complete_10 with storage village_trader:runtime bossbar
