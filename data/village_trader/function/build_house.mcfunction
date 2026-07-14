# 9x9 特殊交易屋。函数原点是地板中心。
fill ~-4 ~ ~-4 ~4 ~6 ~4 minecraft:air
fill ~-4 ~-1 ~-4 ~4 ~-1 ~4 minecraft:cobblestone
fill ~-4 ~ ~-4 ~4 ~ ~4 minecraft:spruce_planks

# 墙体与木柱
fill ~-4 ~1 ~-4 ~4 ~4 ~-4 minecraft:oak_planks
fill ~-4 ~1 ~4 ~4 ~4 ~4 minecraft:oak_planks
fill ~-4 ~1 ~-3 ~-4 ~4 ~3 minecraft:oak_planks
fill ~4 ~1 ~-3 ~4 ~4 ~3 minecraft:oak_planks
fill ~-4 ~1 ~-4 ~-4 ~4 ~-4 minecraft:stripped_spruce_log
fill ~4 ~1 ~-4 ~4 ~4 ~-4 minecraft:stripped_spruce_log
fill ~-4 ~1 ~4 ~-4 ~4 ~4 minecraft:stripped_spruce_log
fill ~4 ~1 ~4 ~4 ~4 ~4 minecraft:stripped_spruce_log

# 窗户、门和屋顶
fill ~-2 ~2 ~-4 ~2 ~3 ~-4 minecraft:glass_pane
fill ~-4 ~2 ~-2 ~-4 ~3 ~2 minecraft:glass_pane
fill ~4 ~2 ~-2 ~4 ~3 ~2 minecraft:glass_pane
setblock ~ ~1 ~4 minecraft:air
setblock ~ ~2 ~4 minecraft:air
setblock ~ ~1 ~4 minecraft:spruce_door[half=lower,facing=south,hinge=left]
setblock ~ ~2 ~4 minecraft:spruce_door[half=upper,facing=south,hinge=left]
fill ~-5 ~5 ~-5 ~5 ~5 ~5 minecraft:dark_oak_planks
fill ~-4 ~6 ~-4 ~4 ~6 ~4 minecraft:dark_oak_slab[type=bottom]

# 室内装饰与照明
fill ~-3 ~1 ~-3 ~-3 ~1 ~2 minecraft:barrel[facing=east]
fill ~3 ~1 ~-3 ~3 ~1 ~2 minecraft:bookshelf
setblock ~-2 ~4 ~ minecraft:lantern[hanging=true]
setblock ~2 ~4 ~ minecraft:lantern[hanging=true]
setblock ~ ~1 ~-3 minecraft:lectern[facing=south,has_book=false]
setblock ~ ~1 ~3 minecraft:oak_pressure_plate

# 锚点用于防止重复生成并维护商人。
summon minecraft:marker ~ ~1 ~ {Tags:["village_trader.house"]}
execute positioned ~ ~1 ~ run function village_trader:spawn_merchant
