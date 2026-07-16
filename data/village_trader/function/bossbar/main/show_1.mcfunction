$bossbar set village_trader:player_$(id) name [{"text":"定居启程 · 工作台,vt_a,1"},{"text":" 工作台 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/1"},{"text":" | 睡床 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/1"},{"text":" | 熔铁 "},{"score":{"name":"@s","objective":"vt_c"}},{"text":"/8"}]
$bossbar set village_trader:player_$(id) max 10
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 1.. if score @s vt_b matches 1.. if score @s vt_c matches 8.. run function village_trader:bossbar/main/complete_1 with storage village_trader:runtime bossbar
