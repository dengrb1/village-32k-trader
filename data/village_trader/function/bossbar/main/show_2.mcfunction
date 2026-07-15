$bossbar set village_trader:player_$(id) name [{"text":"矿脉勘探 · 钻石矿 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/8 | 敌对生物 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/20"}]
$bossbar set village_trader:player_$(id) max 28
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 8.. if score @s vt_b matches 20.. run function village_trader:bossbar/main/complete_2 with storage village_trader:runtime bossbar
