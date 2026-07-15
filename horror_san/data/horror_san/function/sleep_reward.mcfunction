# 仅体验者成功睡觉后恢复 20 点 SAN
execute as @a[tag=horror_san.experiencer,scores={horror_san.act=1..},advancements={horror_san:sleep_reward=true}] run scoreboard players add @s horror_san.san 20
execute as @a[tag=horror_san.experiencer,scores={horror_san.act=1..,horror_san.san=101..},advancements={horror_san:sleep_reward=true}] run scoreboard players set @s horror_san.san 100
execute as @a[tag=horror_san.experiencer,scores={horror_san.act=1..},advancements={horror_san:sleep_reward=true}] run function horror_san:system/update_bossbar
advancement revoke @a only horror_san:sleep_reward
