package cn.villagetrader.model;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public final class ServerState {
  public int schemaVersion = 1;
  public int penaltyLevel;
  public Instant updatedAt = Instant.now();
  public List<ShopRecord> shops = new ArrayList<>();

  public static final class ShopRecord {
    public UUID id = UUID.randomUUID();
    public String world;
    public double x;
    public double y;
    public double z;
    public UUID merchantUuid;
    public boolean houseBuilt;
  }
}
