$bossbar set village_trader:player_$(id) name [{"text":"小小矿工 · 圆石 "},{"score":{"name":"@s","objective":"vt_ca"}},{"text":"/16 | 铁锭 "},{"score":{"name":"@s","objective":"vt_cb"}},{"text":"/3"}]
$bossbar set village_trader:player_$(id) max 19
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color blue
execute if score @s vt_ca matches 16.. if score @s vt_cb matches 3.. run function village_trader:bossbar/child/complete_2 with storage village_trader:runtime bossbar
