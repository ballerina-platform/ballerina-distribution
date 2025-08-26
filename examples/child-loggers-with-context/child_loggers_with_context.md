# Child Loggers with Context

This example demonstrates how to create child loggers with specific additional context using the Ballerina logging module. Child loggers inherit context from their parent loggers, allowing for hierarchical logging with layered context.

::: code contextual-logging.bal :::

::: out contextual-logging.out :::

The contextual logging APIs make it easy to trace complete request flows and correlate related log entries without manually managing context in each log statement.

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#431-loggers-with-additional-context)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
