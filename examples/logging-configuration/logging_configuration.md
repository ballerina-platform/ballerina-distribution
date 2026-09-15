# Log configuration

This example demonstrates how to configure logging behavior using the `Config.toml` file. You can control the log level, format, output destinations, file rotation, and add root context that appears in all log messages.

::: code Config.toml :::

The configuration above sets:

- **level**: `DEBUG` to show all log levels. This is set to the root logger, affecting all modules unless overridden
- **format**: `json` for structured JSON output
- **destinations**: Logs to a file with automatic rotation
- **rotation**: TIME_BASED policy to rotate log files based on age
  - `maxAge`: Maximum age of log files in seconds (5 seconds for demo)
  - `maxBackupFiles`: Number of rotated backup files to retain
- **keyValues**: Root context added to all logs

::: code logging_configuration.bal :::

When you run the application with this configuration, all log messages will be in JSON format and include the root context.

The log messages will be written to the specified file (`./logs/app.log`) and will automatically rotate based on the configured policy.

> **Note:** Ensure that the application has write permissions to the specified log file path.

::: out logging_configuration.out :::

> **Tip:** Each module can also be assigned its own log level. To assign a log level to a module, provide the following entry in the `Config.toml` file:

::: code ModuleConfig.toml :::

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#3-configure-logging)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
