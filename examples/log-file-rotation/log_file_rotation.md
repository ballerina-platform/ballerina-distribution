# Log file rotation

Log file rotation helps manage log file sizes by automatically creating backups when certain conditions are met, preventing disk space issues. This example demonstrates TIME_BASED rotation configured through `Config.toml`.

## Configuring File Rotation

The root logger is configured in `Config.toml` with TIME_BASED rotation. All logs using the default logger will automatically benefit from this rotation policy.

::: code Config.toml :::

::: code log_file_rotation.bal :::

Run the example to see rotation in action:

::: out log_file_rotation.out :::

## How Rotation Works

When a log file rotates, it's renamed with a timestamp suffix and a new file is created:

```
logs/
  app.log                            (current log file)
  app-20251223-225602.log            (rotated backup)
  app-20251223-223015.log            (older backup)
```

Older backups beyond `maxBackupFiles` are automatically deleted.

### Application Log Rotation Output

::: out app_log_rotation.out :::

## Configuration Options

Rotation policies support these configuration parameters:

| Parameter | Default | Description |
|-----------|---------|-------------|
| `policy` | `"BOTH"` | Rotation trigger: `"SIZE_BASED"`, `"TIME_BASED"`, or `"BOTH"` |
| `maxFileSize` | 10485760 | Maximum file size in bytes (10MB default) |
| `maxAge` | 86400 | Maximum file age in seconds (24 hours default) |
| `maxBackupFiles` | 10 | Number of rotated backup files to retain |

> **Note:** This example uses a small threshold (5 seconds) to make rotation observable during demonstration. In production, use realistic values such as `maxAge = 86400` (24 hours).

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest/)
