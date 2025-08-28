# Log configuration

This example demonstrates how to configure logging behavior using the `Config.toml` file. You can control the log level, format, output destinations, and add root context that appears in all log messages.

::: code Config.toml :::

The configuration above sets:

- **level**: `DEBUG` to show all log levels. This is set to the root logger, affecting all modules unless overridden
- **format**: `json` for structured JSON output
- **destinations**: Logs to a file
- **keyValues**: Root context added to all logs

::: code logging_configuration.bal :::

When you run the application with this configuration, all log messages will be in JSON format and include the root context.

The log messages will be written to the specified file (`./logs/app.log`).

> **Note:** Ensure that the application has write permissions to the specified log file path.

::: out logging_configuration.out :::

> **Tip:** Each module can also be assigned its own log level. To assign a log level to a module, provide the following
> entry in the `Config.toml` file:
>
> ```toml
> [[ballerina.log.modules]]
> name = "[ORG_NAME]/[MODULE_NAME]"
> level = "[LOG_LEVEL]"
> ```

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#3-configure-logging)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
