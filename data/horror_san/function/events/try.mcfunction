# 每个 SAN 档位各自决定触发概率；未触发时不消耗冷却。
execute if score @s horror_san.san matches 41..70 run function horror_san:events/try_mild
execute if score @s horror_san.san matches 21..40 run function horror_san:events/try_medium
execute if score @s horror_san.san matches ..20 run function horror_san:events/try_low
