# 每次商人死亡/消失提升一级，全局制裁最高为三级。
scoreboard players add $level vt_penalty 1
execute if score $level vt_penalty matches 4.. run scoreboard players set $level vt_penalty 3
