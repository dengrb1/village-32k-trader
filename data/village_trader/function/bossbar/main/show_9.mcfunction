$bossbar set village_trader:player_$(id) name [{"text":"深暗净化 · 监守者 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/1 | 回响碎片 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/8"}]
$bossbar set village_trader:player_$(id) max 9
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 1.. if score @s vt_b matches 8.. run function village_trader:bossbar/main/complete_9 with storage village_trader:runtime bossbar
