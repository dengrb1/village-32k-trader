# 管理员应以目标玩家身份运行本函数。重新发放会替换目标原有的本包钥匙。
execute unless score @s vt_init matches 1.. run function village_trader:core/init_player
advancement revoke @s only village_trader:portable/use_key
clear @s minecraft:warped_fungus_on_a_stick[minecraft:custom_data~{village_trader_portable_key:1b}]
give @s minecraft:warped_fungus_on_a_stick[minecraft:custom_name='{"text":"便携商店钥匙","color":"gold","italic":false}',minecraft:lore=['{"text":"右键打开个人村庄商店","color":"gray","italic":false}','{"text":"仅对管理员登记的领取者有效","color":"dark_gray","italic":false}'],minecraft:custom_data={village_trader_portable_key:1b},minecraft:max_stack_size=1,minecraft:enchantment_glint_override=true]
scoreboard players set @s vt_portable 1
function village_trader:portable/update
tellraw @s [{"text":"[村庄商人] ","color":"gold"},{"text":"管理员已发放并登记你的便携商店钥匙。","color":"green"}]
