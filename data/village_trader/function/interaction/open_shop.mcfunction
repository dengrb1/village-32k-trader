# advancement 奖励以交互玩家为执行者。
advancement revoke @s only village_trader:interaction/open_shop
execute unless score @s vt_init matches 1.. run function village_trader:core/init_player
function village_trader:menu/open
