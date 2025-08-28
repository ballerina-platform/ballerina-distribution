# Logger from configuration

This example demonstrates how to create specialized loggers with unique configurations. Each logger can have its own format, destinations, log level, and default context.

::: code logger_from_config.bal :::

> **Note:** All loggers created from the configuration automatically inherit the root logger default context.

::: code Config.toml :::

Terminal output:
::: out logger_from_config.out :::

Audit logs:
::: out audit_logs.out :::

Metrics logs:
::: out metrics_logs.out :::

Notice how each logger type produces different output but all share the default context. This pattern is ideal for applications that need different logging behaviors for different concerns (audit trails, performance monitoring, security events, etc.).

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#432-loggers-with-unique-logging-configuration)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
