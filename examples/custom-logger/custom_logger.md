# Custom logger

This example demonstrates how to implement custom loggers that conform to the `log:Logger` type. Custom loggers can automatically include specific context and provide specialized logging behavior for different components.

::: code custom_logger.bal :::

::: out custom_logger.out :::

> **Note:** In this example, the log module print methods are used to simulate the logging behaviour. So the root logger configurations will be applied to the log messages. But in a real world scenario, you would implement the actual logging logic inside the custom logger methods with custom log formats and destinations.

The custom logger implementation allows for flexible and reusable logging strategies tailored to specific application needs.

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#41-logger)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
