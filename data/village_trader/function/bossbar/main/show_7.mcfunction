$bossbar set village_trader:player_$(id) name [{"text":"试炼密室 · 旋风人 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/3 | 试炼钥匙 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 4
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 3.. if score @s vt_b matches 1.. run function village_trader:bossbar/main/complete_7 with storage village_trader:runtime bossbar
