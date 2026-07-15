execute unless score @s vt_child matches 1 run return 0
execute unless score @s vt_cqown matches 1 run title @s actionbar {"text":"提交失败：当前任务牌尚未兑换并登记所有权。","color":"red"}
execute unless score @s vt_cactive matches 1 run title @s actionbar {"text":"提交失败：当前任务牌尚未激活。","color":"red"}
execute unless score @s vt_cqown matches 1 run return 0
execute unless score @s vt_cactive matches 1 run return 0
scoreboard players set @s vt_ok 0
execute if score @s vt_cstage matches 1 if score @s vt_ca matches 1.. if score @s vt_cb matches 1.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cstage matches 2 if score @s vt_ca matches 16.. if score @s vt_cb matches 3.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cstage matches 3 if score @s vt_ca matches 8.. if score @s vt_cb matches 1.. if score @s vt_cc matches 1.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cstage matches 4 if score @s vt_ca matches 1.. if score @s vt_cb matches 3.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cstage matches 5 if score @s vt_ca matches 1.. if score @s vt_cb matches 1.. if score @s vt_cc matches 1.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cstage matches 6 if score @s vt_ca matches 1.. run scoreboard players set @s vt_ok 1
execute if score @s vt_cstage matches 1 unless score @s vt_ca matches 1.. unless score @s vt_cb matches 1.. run title @s actionbar {"text":"提交失败：还需在激活后持有4个原木，并持有或新制作工作台。","color":"red"}
execute if score @s vt_cstage matches 1 unless score @s vt_ca matches 1.. if score @s vt_cb matches 1.. run title @s actionbar {"text":"提交失败：还需在激活后持有至少4个原木。","color":"red"}
execute if score @s vt_cstage matches 1 if score @s vt_ca matches 1.. unless score @s vt_cb matches 1.. run title @s actionbar {"text":"提交失败：还需持有或新制作一个工作台。","color":"red"}
execute if score @s vt_cstage matches 2 unless score @s vt_ca matches 16.. run title @s actionbar {"text":"提交失败：圆石目标未完成（需亲自挖掘16个）。","color":"red"}
execute if score @s vt_cstage matches 2 if score @s vt_ca matches 16.. unless score @s vt_cb matches 3.. run title @s actionbar {"text":"提交失败：铁锭目标未完成（需亲自取出3次）。","color":"red"}
execute if score @s vt_cstage matches 3 unless score @s vt_ca matches 8.. run title @s actionbar {"text":"提交失败：火把目标未完成（需放置8支）。","color":"red"}
execute if score @s vt_cstage matches 3 if score @s vt_ca matches 8.. unless score @s vt_cb matches 1.. run title @s actionbar {"text":"提交失败：还需要进食一次。","color":"red"}
execute if score @s vt_cstage matches 3 if score @s vt_ca matches 8.. if score @s vt_cb matches 1.. unless score @s vt_cc matches 1.. run title @s actionbar {"text":"提交失败：还需要成功睡床一次。","color":"red"}
execute if score @s vt_cstage matches 4 unless score @s vt_ca matches 1.. run title @s actionbar {"text":"提交失败：还需将盾牌装备在副手。","color":"red"}
execute if score @s vt_cstage matches 4 if score @s vt_ca matches 1.. unless score @s vt_cb matches 3.. run title @s actionbar {"text":"提交失败：还需击杀3只僵尸或骷髅。","color":"red"}
execute if score @s vt_cstage matches 5 unless score @s vt_ca matches 1.. run title @s actionbar {"text":"提交失败：还需购买一次儿童普通商品。","color":"red"}
execute if score @s vt_cstage matches 5 if score @s vt_ca matches 1.. unless score @s vt_cb matches 1.. run title @s actionbar {"text":"提交失败：还需亲自挖掘1个钻石矿。","color":"red"}
execute if score @s vt_cstage matches 5 if score @s vt_ca matches 1.. if score @s vt_cb matches 1.. unless score @s vt_cc matches 1.. run title @s actionbar {"text":"提交失败：背包还需持有4个绿宝石。","color":"red"}
execute if score @s vt_cstage matches 6 unless score @s vt_ca matches 1.. run title @s actionbar {"text":"提交失败：还需在激活后右键本数据包商人一次。","color":"red"}
execute unless score @s vt_ok matches 1 run return 0
scoreboard players set @s vt_ok 0
execute if score @s vt_cstage matches 1 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:1}] 1
execute if score @s vt_cstage matches 2 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:2}] 1
execute if score @s vt_cstage matches 3 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:3}] 1
execute if score @s vt_cstage matches 4 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:4}] 1
execute if score @s vt_cstage matches 5 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:5}] 1
execute if score @s vt_cstage matches 6 store result score @s vt_ok run clear @s minecraft:paper[minecraft:custom_data~{kind:"child_quest",id:6}] 1
execute unless score @s vt_ok matches 1 run title @s actionbar {"text":"提交失败：缺少当前章节任务牌；辅助用品不能代替。","color":"red"}
execute unless score @s vt_ok matches 1 run return 0
scoreboard players set @s vt_cqown 0
scoreboard players set @s vt_cqrep 0
scoreboard players set @s vt_cactive 0
scoreboard players set @s vt_ca 0
scoreboard players set @s vt_cb 0
scoreboard players set @s vt_cc 0
scoreboard players add @s vt_cstage 1
execute if score @s vt_cstage matches 7 run scoreboard players set @s vt_bstage 1
execute if score @s vt_cstage matches 7 run tellraw @s {"text":"守护毕业！Boss 番外现已开放。","color":"gold","bold":true}
execute unless score @s vt_cstage matches 7 run tellraw @s {"text":"任务牌已消耗，下一章已解锁。","color":"green"}
