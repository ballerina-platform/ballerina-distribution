# Logging with context

This example demonstrates how to add contextual information to log messages using key-value pairs. This helps in debugging and monitoring by providing additional metadata with each log entry.

::: code logging_with_context.bal :::

The key-value pairs can include various data types such as strings, numbers, booleans, records, function pointers, and templates. This contextual information makes logs more informative and easier to analyze.

::: out logging_with_context.out :::

Key-value pairs appear as additional fields in the log output, making it easy to filter and search logs based on specific criteria.

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#2-logging)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
