$bossbar set village_trader:player_$(id) name [{"text":"深暗净化 · 监守者,vt_a,1"},{"text":" 监守者 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/1"},{"text":" | 回响碎片 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/8"},{"text":" | 远古城市 "},{"score":{"name":"@s","objective":"vt_c"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 10
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 1.. if score @s vt_b matches 8.. if score @s vt_c matches 1.. run function village_trader:bossbar/main/complete_9 with storage village_trader:runtime bossbar
