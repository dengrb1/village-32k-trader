$bossbar set village_trader:player_$(id) name [{"text":"试炼密室 · 旋风人,vt_a,3"},{"text":" 旋风人 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/3"},{"text":" | 试炼钥匙 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/1"},{"text":" | 沼骸 "},{"score":{"name":"@s","objective":"vt_c"}},{"text":"/3"}]
$bossbar set village_trader:player_$(id) max 7
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 3.. if score @s vt_b matches 1.. if score @s vt_c matches 3.. run function village_trader:bossbar/main/complete_7 with storage village_trader:runtime bossbar
