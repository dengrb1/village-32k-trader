$bossbar set village_trader:player_$(id) name [{"text":"商人助手 · 购买 "},{"score":{"name":"@s","objective":"vt_ca"}},{"text":"/1 | 钻石矿 "},{"score":{"name":"@s","objective":"vt_cb"}},{"text":"/1 | 绿宝石 "},{"score":{"name":"@s","objective":"vt_cc"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 3
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color blue
execute if score @s vt_ca matches 1.. if score @s vt_cb matches 1.. if score @s vt_cc matches 1.. run function village_trader:bossbar/child/complete_5 with storage village_trader:runtime bossbar
