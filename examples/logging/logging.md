# Logging

This example demonstrates how to log messages at different levels in Ballerina. The log module provides four log levels in order of priority: ERROR, WARN, INFO, and DEBUG.

::: code logging.bal :::

By default, only INFO and higher level logs (INFO, WARN, ERROR) are displayed. DEBUG logs are filtered out unless explicitly configured.

::: out logging.out :::

> **Note:** The DEBUG message is not shown in the output because the default log level is INFO.

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#2-logging)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
