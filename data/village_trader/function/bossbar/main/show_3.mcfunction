$bossbar set village_trader:player_$(id) name [{"text":"下界远征 · 下界,vt_a,1"},{"text":" 下界 "},{"score":{"name":"@s","objective":"vt_a"}},{"text":"/1"},{"text":" | 烈焰人 "},{"score":{"name":"@s","objective":"vt_b"}},{"text":"/10"},{"text":" | 残骸 "},{"score":{"name":"@s","objective":"vt_c"}},{"text":"/4"},{"text":" | 猪灵 "},{"score":{"name":"@s","objective":"vt_d"}},{"text":"/5"}]
$bossbar set village_trader:player_$(id) max 20
$bossbar set village_trader:player_$(id) value $(value)
$bossbar set village_trader:player_$(id) color purple
execute if score @s vt_a matches 1.. if score @s vt_b matches 10.. if score @s vt_c matches 4.. if score @s vt_d matches 5.. run function village_trader:bossbar/main/complete_3 with storage village_trader:runtime bossbar
