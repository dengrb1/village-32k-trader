$bossbar set village_trader:player_$(id) name [{"text":"守护毕业 · 商人互动 "},{"score":{"name":"@s","objective":"vt_ca"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 1
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color blue
execute if score @s vt_ca matches 1.. run function village_trader:bossbar/child/complete_6 with storage village_trader:runtime bossbar
