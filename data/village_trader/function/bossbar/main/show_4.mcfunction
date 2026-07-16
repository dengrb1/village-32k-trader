$bossbar set village_trader:player_$(id) name [{"text":"沧海巡航 · 守卫者,vt_a,1"},{"text":" 守卫者 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/1"},{"text":" | 潮涌核心 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/1"},{"text":" | 海底神殿 "},{"score":{"name":"@s","objective":"vt_c"}},{"text":"/1"}]
$bossbar set village_trader:player_$(id) max 3
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 1.. if score @s vt_b matches 1.. if score @s vt_c matches 1.. run function village_trader:bossbar/main/complete_4 with storage village_trader:runtime bossbar
