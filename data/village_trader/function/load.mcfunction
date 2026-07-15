# 村庄成长商店公共加载入口。只补定义和缺失的全局值，不重置玩家进度。
scoreboard objectives add vt_init dummy
scoreboard objectives add vt_menu trigger
scoreboard objectives add vt_action trigger
scoreboard objectives add vt_ui dummy
scoreboard objectives add vt_ui_last dummy
scoreboard objectives add vt_ui_card dummy
scoreboard objectives add vt_portable dummy
scoreboard objectives add vt_key_cd dummy
scoreboard objectives add vt_stage dummy
scoreboard objectives add vt_diff dummy
scoreboard objectives add vt_gear dummy
scoreboard objectives add vt_qown dummy
scoreboard objectives add vt_qrep dummy
scoreboard objectives add vt_qactive dummy
scoreboard objectives add vt_a dummy
scoreboard objectives add vt_b dummy
scoreboard objectives add vt_c dummy
scoreboard objectives add vt_child dummy
scoreboard objectives add vt_cstage dummy
scoreboard objectives add vt_cqown dummy
scoreboard objectives add vt_cqrep dummy
scoreboard objectives add vt_cactive dummy
scoreboard objectives add vt_ca dummy
scoreboard objectives add vt_cb dummy
scoreboard objectives add vt_cc dummy
scoreboard objectives add vt_bstage dummy
scoreboard objectives add vt_bqown dummy
scoreboard objectives add vt_bactive dummy
scoreboard objectives add vt_asc dummy
scoreboard objectives add vt_asckey dummy
scoreboard objectives add vt_aux dummy
scoreboard objectives add vt_caux dummy
scoreboard objectives add vt_nvpause dummy
scoreboard objectives add vt_nvsusp dummy
scoreboard objectives add vt_healcd dummy
scoreboard objectives add vt_tmp dummy
scoreboard objectives add vt_ok dummy
scoreboard objectives add vt_penalty dummy
scoreboard objectives add vt_mdia minecraft.mined:minecraft.diamond_ore
scoreboard objectives add vt_mddia minecraft.mined:minecraft.deepslate_diamond_ore
scoreboard objectives add vt_mdebris minecraft.mined:minecraft.ancient_debris
scoreboard objectives add vt_mcob minecraft.mined:minecraft.cobblestone
scoreboard objectives add vt_ptotem minecraft.picked_up:minecraft.totem_of_undying
scoreboard objectives add vt_bdia dummy
scoreboard objectives add vt_bddia dummy
scoreboard objectives add vt_bdebris dummy
scoreboard objectives add vt_cbdia dummy
scoreboard objectives add vt_cbddia dummy
scoreboard objectives add vt_cbcob dummy
scoreboard objectives add vt_btotem dummy
execute unless score $level vt_penalty matches -2147483648..2147483647 run scoreboard players set $level vt_penalty 0
execute if score $level vt_penalty matches ..-1 run scoreboard players set $level vt_penalty 0
execute if score $level vt_penalty matches 4.. run scoreboard players set $level vt_penalty 3
data modify storage village_trader:state installed set value 1b
function village_trader:ui/cleanup_all
tellraw @a [{"text":"[村庄商人] ","color":"gold"},{"text":"数据包已加载（Java 26.1.2）","color":"green"}]
function village_trader:penalty/refresh
schedule function village_trader:scan 1s replace
schedule function village_trader:second 1s replace
