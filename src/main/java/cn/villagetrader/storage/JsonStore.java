package cn.villagetrader.storage;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonParseException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.AtomicMoveNotSupportedException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.Instant;
import java.time.format.DateTimeFormatter;
import java.util.Objects;

public final class JsonStore {
  private final Gson gson = new GsonBuilder()
      .setPrettyPrinting()
      .disableHtmlEscaping()
      .registerTypeAdapter(Instant.class, new InstantAdapter())
      .create();

  public Gson gson() { return gson; }

  public <T> T read(Path file, Class<T> type) throws IOException {
    try {
      String json = Files.readString(file, StandardCharsets.UTF_8);
      T value = gson.fromJson(json, type);
      return Objects.requireNonNull(value, "JSON 根节点不能为 null");
    } catch (JsonParseException | NullPointerException ex) {
      throw new IOException("JSON 解析失败: " + file, ex);
    }
  }

  public void writeAtomic(Path file, Object value) throws IOException {
    Files.createDirectories(file.getParent());
    Path temporary = file.resolveSibling(file.getFileName() + ".tmp");
    Files.writeString(temporary, gson.toJson(value) + System.lineSeparator(), StandardCharsets.UTF_8);
    try {
      Files.move(temporary, file, StandardCopyOption.ATOMIC_MOVE, StandardCopyOption.REPLACE_EXISTING);
    } catch (AtomicMoveNotSupportedException ex) {
      Files.move(temporary, file, StandardCopyOption.REPLACE_EXISTING);
    }
  }

  public Path backup(Path file, Path backupDirectory, String reason) throws IOException {
    if (!Files.exists(file)) return null;
    Files.createDirectories(backupDirectory);
    String stamp = DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss-SSS")
        .withZone(java.time.ZoneOffset.UTC).format(Instant.now());
    Path target = backupDirectory.resolve(file.getFileName() + "." + stamp + "." + reason + ".bak");
    return Files.copy(file, target, StandardCopyOption.COPY_ATTRIBUTES);
  }

  private static final class InstantAdapter extends com.google.gson.TypeAdapter<Instant> {
    @Override public void write(com.google.gson.stream.JsonWriter out, Instant value) throws IOException {
      if (value == null) out.nullValue(); else out.value(value.toString());
    }
    @Override public Instant read(com.google.gson.stream.JsonReader in) throws IOException {
      if (in.peek() == com.google.gson.stream.JsonToken.NULL) { in.nextNull(); return null; }
      return Instant.parse(in.nextString());
    }
  }
}
