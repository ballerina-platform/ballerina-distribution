# Log file rotation

Log file rotation helps manage log file sizes by automatically creating backups when certain conditions are met, preventing disk space issues. Ballerina supports different rotation policies to suit various use cases.

This example demonstrates two common rotation policies:
- **TIME_BASED**: Rotates based on file age (time since creation)
- **SIZE_BASED**: Rotates when the file reaches a specified size threshold

## Configuring the Root Logger

The root logger is configured in `Config.toml` with TIME_BASED rotation. All logs using the default logger will automatically benefit from this rotation policy.

::: code Config.toml :::

## Programmatic Logger Configuration

You can also create custom loggers programmatically with their own rotation policies and add context to them.

::: code log_file_rotation.bal :::

The example demonstrates:
- **Root logger** (Config.toml): TIME_BASED rotation for general application logs
- **Programmatic logger**: SIZE_BASED rotation for audit logs with contextual information (sessionId, userId)

Run the example to see rotation in action:

::: out log_file_rotation.out :::

## Configuration Options

Rotation policies support these configuration parameters:

| Parameter | Default | Description |
|-----------|---------|-------------|
| `policy` | `"BOTH"` | Rotation trigger: `"SIZE_BASED"`, `"TIME_BASED"`, or `"BOTH"` |
| `maxFileSize` | 10485760 | Maximum file size in bytes (10MB default) |
| `maxAge` | 86400 | Maximum file age in seconds (24 hours default) |
| `maxBackupFiles` | 10 | Number of rotated backup files to retain |

## How Rotation Works

When a log file rotates, it's renamed with a timestamp suffix and a new file is created:

```
logs/
  app.log                            (current log file)
  app-20251223-225602.log            (rotated backup)
  app-20251223-223015.log            (older backup)
```

Older backups beyond `maxBackupFiles` are automatically deleted.

### Application Log Rotation (TIME_BASED)

::: out app_log_rotation.out :::

### Audit Log Rotation (SIZE_BASED)

::: out audit_log_rotation.out :::

> **Note:** This example uses small thresholds (5 seconds for time, 1KB for size) to make rotation observable during demonstration. In production, use realistic values such as `maxFileSize = 10485760` (10MB) and `maxAge = 86400` (24 hours).

## Related links
- [`log` module - Specification](https://lib.ballerina.io/ballerina/log/latest/)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest/)
