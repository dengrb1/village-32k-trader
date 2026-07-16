# 每 tick 的主线轻量检测；动作路由由公共层调用。
# 儿童线启用时冻结主线挖掘增量，同时保留已经取得的主线计数。
execute if score @s vt_child matches 1 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_bdia = @s vt_mdia
execute if score @s vt_child matches 1 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_bdia -= @s vt_a
execute if score @s vt_child matches 1 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_bddia = @s vt_mddia
execute if score @s vt_child matches 1 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_bredstone = @s vt_mredstone
execute if score @s vt_child matches 1 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_bredstone -= @s vt_c
execute if score @s vt_child matches 1 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_bdredstone = @s vt_mdredstone
execute if score @s vt_child matches 1 if score @s vt_qactive matches 3 run scoreboard players operation @s vt_bdebris = @s vt_mdebris
execute if score @s vt_child matches 1 if score @s vt_qactive matches 3 run scoreboard players operation @s vt_bdebris -= @s vt_c
execute if score @s vt_child matches 1 if score @s vt_qactive matches 6 if score @s vt_a matches 1.. run scoreboard players operation @s vt_btotem = @s vt_ptotem
execute if score @s vt_child matches 1 if score @s vt_qactive matches 6 if score @s vt_a matches 1.. run scoreboard players operation @s vt_btotem -= @s vt_b
execute if score @s vt_child matches 1 if score @s vt_qactive matches 7 run scoreboard players operation @s vt_butkey = @s vt_utkey
execute if score @s vt_child matches 1 if score @s vt_qactive matches 7 run scoreboard players operation @s vt_butkey -= @s vt_b
execute if score @s vt_child matches 1 if score @s vt_qactive matches 9 run scoreboard players operation @s vt_bpecho = @s vt_pecho
execute if score @s vt_child matches 1 if score @s vt_qactive matches 9 run scoreboard players operation @s vt_bpecho -= @s vt_b
execute if score @s vt_child matches 1 if score @s vt_qactive matches 10 run scoreboard players operation @s vt_bucrystal = @s vt_ucrystal
execute if score @s vt_child matches 1 if score @s vt_qactive matches 10 run scoreboard players operation @s vt_bucrystal -= @s vt_a
execute if score @s vt_child matches 1 if score @s vt_qactive matches 8 run scoreboard players operation @s vt_bskull = @s vt_pskull
execute if score @s vt_child matches 1 if score @s vt_qactive matches 8 run scoreboard players operation @s vt_bskull -= @s vt_c
execute if score @s vt_child matches 1 if score @s vt_qactive matches 10 run scoreboard players operation @s vt_bbreath = @s vt_pbreath
execute if score @s vt_child matches 1 if score @s vt_qactive matches 10 run scoreboard players operation @s vt_bbreath -= @s vt_c
execute unless score @s vt_child matches 0 run return 0
execute unless score @s vt_stage matches 1..11 run scoreboard players set @s vt_stage 1
execute unless score @s vt_diff matches 0..1 run scoreboard players set @s vt_diff 0
execute unless score @s vt_gear matches 0..7 run scoreboard players set @s vt_gear 0
execute unless score @s vt_good matches 0..30 run scoreboard players set @s vt_good 0
execute unless score @s vt_buy_pending matches 0..64 run scoreboard players set @s vt_buy_pending 0
execute unless score @s vt_qown matches 0..10 run scoreboard players set @s vt_qown 0
execute unless score @s vt_qrep matches 0..1 run scoreboard players set @s vt_qrep 0
execute unless score @s vt_qactive matches 0..11 run scoreboard players set @s vt_qactive 0
execute unless score @s vt_aux matches 0..8 run scoreboard players set @s vt_aux 0
scoreboard players enable @s vt_action

# 26.1.2 没有 mined_block advancement，使用激活时保存的个人统计基线。
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_a = @s vt_mdia
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_a -= @s vt_bdia
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_tmp = @s vt_mddia
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_tmp -= @s vt_bddia
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_a += @s vt_tmp
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 if score @s vt_a matches ..-1 run scoreboard players set @s vt_a 0
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 if score @s vt_a matches 9.. run scoreboard players set @s vt_a 8
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_c = @s vt_mredstone
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_c -= @s vt_bredstone
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_tmp = @s vt_mdredstone
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_tmp -= @s vt_bdredstone
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 run scoreboard players operation @s vt_c += @s vt_tmp
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 if score @s vt_c matches ..-1 run scoreboard players set @s vt_c 0
execute if score @s vt_stage matches 2 if score @s vt_qactive matches 2 if score @s vt_c matches 9.. run scoreboard players set @s vt_c 8
execute if score @s vt_stage matches 3 if score @s vt_qactive matches 3 run scoreboard players operation @s vt_c = @s vt_mdebris
execute if score @s vt_stage matches 3 if score @s vt_qactive matches 3 run scoreboard players operation @s vt_c -= @s vt_bdebris
execute if score @s vt_stage matches 3 if score @s vt_qactive matches 3 if score @s vt_c matches ..-1 run scoreboard players set @s vt_c 0
execute if score @s vt_stage matches 3 if score @s vt_qactive matches 3 if score @s vt_c matches 5.. run scoreboard players set @s vt_c 4

# 试炼密钥、回响碎片与末地水晶均以激活时保存的个人统计基线计算，历史行为不会直接完成任务。
execute if score @s vt_stage matches 7 if score @s vt_qactive matches 7 run scoreboard players operation @s vt_b = @s vt_utkey
execute if score @s vt_stage matches 7 if score @s vt_qactive matches 7 run scoreboard players operation @s vt_b -= @s vt_butkey
execute if score @s vt_stage matches 7 if score @s vt_qactive matches 7 if score @s vt_b matches ..-1 run scoreboard players set @s vt_b 0
execute if score @s vt_stage matches 7 if score @s vt_qactive matches 7 if score @s vt_b matches 2.. run scoreboard players set @s vt_b 1
execute if score @s vt_stage matches 9 if score @s vt_qactive matches 9 run scoreboard players operation @s vt_b = @s vt_pecho
execute if score @s vt_stage matches 9 if score @s vt_qactive matches 9 run scoreboard players operation @s vt_b -= @s vt_bpecho
execute if score @s vt_stage matches 9 if score @s vt_qactive matches 9 if score @s vt_b matches ..-1 run scoreboard players set @s vt_b 0
execute if score @s vt_stage matches 9 if score @s vt_qactive matches 9 if score @s vt_b matches 9.. run scoreboard players set @s vt_b 8
execute if score @s vt_stage matches 10 if score @s vt_qactive matches 10 run scoreboard players operation @s vt_a = @s vt_ucrystal
execute if score @s vt_stage matches 10 if score @s vt_qactive matches 10 run scoreboard players operation @s vt_a -= @s vt_bucrystal
execute if score @s vt_stage matches 10 if score @s vt_qactive matches 10 if score @s vt_a matches ..-1 run scoreboard players set @s vt_a 0
execute if score @s vt_stage matches 10 if score @s vt_qactive matches 10 if score @s vt_a matches 5.. run scoreboard players set @s vt_a 4
execute if score @s vt_stage matches 8 if score @s vt_qactive matches 8 run scoreboard players operation @s vt_c = @s vt_pskull
execute if score @s vt_stage matches 8 if score @s vt_qactive matches 8 run scoreboard players operation @s vt_c -= @s vt_bskull
execute if score @s vt_stage matches 8 if score @s vt_qactive matches 8 if score @s vt_c matches ..-1 run scoreboard players set @s vt_c 0
execute if score @s vt_stage matches 8 if score @s vt_qactive matches 8 if score @s vt_c matches 4.. run scoreboard players set @s vt_c 3
execute if score @s vt_stage matches 10 if score @s vt_qactive matches 10 run scoreboard players operation @s vt_c = @s vt_pbreath
execute if score @s vt_stage matches 10 if score @s vt_qactive matches 10 run scoreboard players operation @s vt_c -= @s vt_bbreath
execute if score @s vt_stage matches 10 if score @s vt_qactive matches 10 if score @s vt_c matches ..-1 run scoreboard players set @s vt_c 0
execute if score @s vt_stage matches 10 if score @s vt_qactive matches 10 if score @s vt_c matches 5.. run scoreboard players set @s vt_c 4

# 袭击胜利后，必须在任务激活后亲自拾取过图腾；商店 /give 不会增加该统计。
execute if score @s vt_stage matches 6 if score @s vt_qactive matches 6 if score @s vt_a matches 1.. run scoreboard players operation @s vt_tmp = @s vt_ptotem
execute if score @s vt_stage matches 6 if score @s vt_qactive matches 6 if score @s vt_a matches 1.. run scoreboard players operation @s vt_tmp -= @s vt_btotem
execute if score @s vt_stage matches 6 if score @s vt_qactive matches 6 if score @s vt_a matches 1.. if score @s vt_tmp matches 1.. run scoreboard players set @s vt_b 1
