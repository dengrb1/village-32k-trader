package cn.villagetrader.storage;

import cn.villagetrader.model.ServerState;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Instant;

public final class ServerStateManager {
  private final JsonStore json;
  private final Path file;
  private final Path backups;
  private final boolean createdNew;
  private ServerState state;

  public ServerStateManager(Path dataDir, JsonStore json) throws IOException {
    this.json = json;
    file = dataDir.resolve("server-state.json");
    backups = dataDir.resolve("backups");
    createdNew = !Files.exists(file);
    if (!createdNew) {
      try { state = json.read(file, ServerState.class); }
      catch (IOException ex) {
        json.backup(file, backups, "broken-server-state");
        throw ex;
      }
    } else state = new ServerState();
    state.penaltyLevel = Math.max(0, Math.min(3, state.penaltyLevel));
  }

  public ServerState state() { return state; }
  public boolean createdNew() { return createdNew; }
  public synchronized void save() throws IOException { state.updatedAt = Instant.now(); json.writeAtomic(file, state); }
  public synchronized void setPenalty(int level) throws IOException { state.penaltyLevel = Math.max(0, Math.min(3, level)); save(); }
  public synchronized void increasePenalty() throws IOException { setPenalty(state.penaltyLevel + 1); }
}
