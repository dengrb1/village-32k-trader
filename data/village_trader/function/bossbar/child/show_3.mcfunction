$bossbar set village_trader:player_$(id) name [{"text":"安全过夜 · 火把 "},{"score":{"name":"@s","objective":"vt_ca"}},{"text":"/8 | 进食 "},{"score":{"name":"@s","objective":"vt_cb"}},{"text":"/1 | 睡眠 "},{"score":{"name":"@s","objective":"vt_cc"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 10
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color blue
execute if score @s vt_ca matches 8.. if score @s vt_cb matches 1.. if score @s vt_cc matches 1.. run function village_trader:bossbar/child/complete_3 with storage village_trader:runtime bossbar
