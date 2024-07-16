# HTTP service - Access logs

Ballerina allows enabling HTTP access logs, which can be used to record the HTTP requests handled by the application. HTTP access logs are disabled by default. To enable them, set `console=true` under `ballerina.http.accessLogConfig` in the `Config.toml` file. Additionally, the path field can be used to define the file path for saving the access logs, offering flexible log management. The log format can be specified using the optional `format` field, with `flat` and `json` as available options, defaulting to `flat`. Furthermore, you can customize the logged attributes by listing them in the optional `attributes` field.

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
