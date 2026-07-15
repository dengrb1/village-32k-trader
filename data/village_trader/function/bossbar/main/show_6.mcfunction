$bossbar set village_trader:player_$(id) name [{"text":"深暗挑战 · 监守者 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 1
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 1.. run function village_trader:bossbar/main/complete_6 with storage village_trader:runtime bossbar
