# SAN 分档：绿、黄、红、紫
execute store result bossbar horror_san:san value run scoreboard players get @s horror_san.san
bossbar set horror_san:san players @a[tag=horror_san.experiencer,scores={horror_san.act=1..}]
bossbar set horror_san:san visible true
execute if score @s horror_san.san matches 71.. run bossbar set horror_san:san color green
execute if score @s horror_san.san matches 71.. run bossbar set horror_san:san name {"text":"SAN ","color":"green","bold":true,"extra":[{"score":{"name":"@s","objective":"horror_san.san"},"color":"green"},{"text":" / 100","color":"green"}]}
execute if score @s horror_san.san matches 41..70 run bossbar set horror_san:san color yellow
execute if score @s horror_san.san matches 41..70 run bossbar set horror_san:san name {"text":"SAN ","color":"yellow","bold":true,"extra":[{"score":{"name":"@s","objective":"horror_san.san"},"color":"yellow"},{"text":" / 100","color":"yellow"}]}
execute if score @s horror_san.san matches 21..40 run bossbar set horror_san:san color red
execute if score @s horror_san.san matches 21..40 run bossbar set horror_san:san name {"text":"SAN ","color":"red","bold":true,"extra":[{"score":{"name":"@s","objective":"horror_san.san"},"color":"red"},{"text":" / 100","color":"red"}]}
execute if score @s horror_san.san matches ..20 run bossbar set horror_san:san color purple
execute if score @s horror_san.san matches ..20 run bossbar set horror_san:san name {"text":"SAN ","color":"light_purple","bold":true,"extra":[{"score":{"name":"@s","objective":"horror_san.san"},"color":"light_purple"},{"text":" / 100","color":"light_purple"}]}
