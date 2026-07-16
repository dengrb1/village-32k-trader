advancement revoke @s only village_trader:portable/use_key
execute if score @s vt_key_cd matches 1.. run return 0
scoreboard players set @s vt_key_cd 5
execute unless score @s vt_init matches 1.. run function village_trader:core/init_player
execute unless score @s vt_portable matches 1 run title @s actionbar {"text":"这把便携商店钥匙未绑定给你，无法使用。","color":"red"}
execute if score @s vt_portable matches 1 run function village_trader:menu/open
