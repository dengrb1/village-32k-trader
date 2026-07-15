# 卸载后 tick 标签仍会被原版调用，因此用 storage 开关避免访问已删除的计分板。
execute if data storage village_trader:state installed run function village_trader:core/tick
