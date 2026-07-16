scoreboard players operation @s vt_progress_done = @s vt_stage
scoreboard players remove @s vt_progress_done 1
execute if score @s vt_progress_done matches ..-1 run scoreboard players set @s vt_progress_done 0
execute if score @s vt_progress_done matches 11.. run scoreboard players set @s vt_progress_done 10
execute if score @s vt_stage matches 1 run dialog show @s village_trader:main_progress_s1
execute if score @s vt_stage matches 2 run dialog show @s village_trader:main_progress_s2
execute if score @s vt_stage matches 3 run dialog show @s village_trader:main_progress_s3
execute if score @s vt_stage matches 4 run dialog show @s village_trader:main_progress_s4
execute if score @s vt_stage matches 5 run dialog show @s village_trader:main_progress_s5
execute if score @s vt_stage matches 6 run dialog show @s village_trader:main_progress_s6
execute if score @s vt_stage matches 7 run dialog show @s village_trader:main_progress_s7
execute if score @s vt_stage matches 8 run dialog show @s village_trader:main_progress_s8
execute if score @s vt_stage matches 9 run dialog show @s village_trader:main_progress_s9
execute if score @s vt_stage matches 10 run dialog show @s village_trader:main_progress_s10
execute if score @s vt_stage matches 11.. run dialog show @s village_trader:main_progress_s11
