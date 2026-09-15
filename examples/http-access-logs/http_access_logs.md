# HTTP service - Access logs

Ballerina allows enabling HTTP access logs to record the HTTP requests handled by an application. HTTP access logs are disabled by default. To enable them, set `console=true` under `ballerina.http.accessLogConfig` in the `Config.toml` file.
In addition to logging to the console, logs can be written to a file using the `file` configuration. This configuration allows specifying the log file location and related settings, including log rotation.

The log format can be specified as either `flat` or `json` using the optional `format` field (defaults to `flat`). Furthermore, you can customize the logged attributes using the optional `attributes` field.

::: code http_access_logs.bal :::

## Prerequisites
- Populate the `Config.toml` file with the access log configurations.

::: code Config.toml :::

Run the service as follows.

::: out http_access_logs.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_access_logs.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/) example.

## Related links
- [`http:AccessLogConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/http/latest#AccessLogConfiguration)
- [HTTP service access log - Specification](/spec/http/#824-access-log)
