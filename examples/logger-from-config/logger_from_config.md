# Logger from configuration

This example demonstrates how to create specialized loggers with unique configurations. Each logger can have its own format, destinations, log level, file rotation policy, and default context.

::: code logger_from_config.bal :::

The example creates two specialized loggers:
- **Audit logger**: Uses SIZE_BASED rotation (10MB file size limit) with JSON format
- **Metrics logger**: Uses TIME_BASED rotation (24-hour age limit) with LOGFMT format

> **Note:** All loggers created from the configuration automatically inherit the default context of the root logger.

::: code Config.toml :::

Terminal output:
::: out logger_from_config.out :::

Audit logs:
::: out audit_logs.out :::

Metrics logs:
::: out metrics_logs.out :::

Notice how each logger type produces different output but all share the default context. Each logger can also have its own rotation policy - the audit logger rotates based on file size (ideal for high-volume logs), while the metrics logger rotates based on time (ideal for daily rollover). This pattern is ideal for applications that need different logging behaviors for different concerns (audit trails, performance monitoring, security events, etc.).

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#432-loggers-with-unique-logging-configuration)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
