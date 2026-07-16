$bossbar set village_trader:player_$(id) name [{"text":"凋灵攻坚 · 凋灵,vt_a,1"},{"text":" 凋灵 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/1"},{"text":" | 信标 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/1"},{"text":" | 凋灵头颅 "},{"score":{"name":"@s","objective":"vt_c"}},{"text":"/3"}]
$bossbar set village_trader:player_$(id) max 5
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 1.. if score @s vt_b matches 1.. if score @s vt_c matches 3.. run function village_trader:bossbar/main/complete_8 with storage village_trader:runtime bossbar
