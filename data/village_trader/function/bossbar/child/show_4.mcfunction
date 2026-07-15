$bossbar set village_trader:player_$(id) name [{"text":"勇气训练 · 盾牌 "},{"score":{"name":"@s","objective":"vt_ca"}},{"text":"/1 | 训练击杀 "},{"score":{"name":"@s","objective":"vt_cb"}},{"text":"/3"}]
$bossbar set village_trader:player_$(id) max 4
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color blue
execute if score @s vt_ca matches 1.. if score @s vt_cb matches 3.. run function village_trader:bossbar/child/complete_4 with storage village_trader:runtime bossbar
