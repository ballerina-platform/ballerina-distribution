# Sensitive data logging

This example demonstrates how to mask sensitive data in log messages using the `@log:Sensitive` annotation. The Ballerina log module provides built-in capabilities to protect personally identifiable information (PII) and other sensitive data from being exposed in logs. By default, sensitive data masking is disabled and must be enabled in the configuration file.

::: code Config.toml :::

There are three masking strategies available:
1. **Exclude strategy (default)**: The sensitive field is completely excluded from log output.
2. **Fixed replacement**: The sensitive field is replaced with a fixed string (e.g., "****").
3. **Custom function replacement**: A custom function is used to mask the sensitive field.

::: code sensitive_data_logging.bal :::

Run the example:

::: out sensitive_data_logging.out :::

## Related links
- [`log` module - Specification](https://ballerina.io/spec/log/#5-sensitive-data-masking)
- [`log` module - API documentation](https://lib.ballerina.io/ballerina/log/latest)
