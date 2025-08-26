# Error Logging

This example demonstrates how to log errors with detailed information including error messages, causes, stack traces, and additional context in Ballerina.

::: code error_logging.bal :::

Error logging in Ballerina automatically includes the error message, stack trace, and any error details. You can also add additional contextual information to help with debugging and monitoring.

::: out error_logging.out :::

The logged errors include comprehensive information such as the error message, causes (for nested errors), stack trace showing the call hierarchy, and any additional context provided through key-value pairs.

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#2-logging)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
