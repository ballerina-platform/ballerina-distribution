# HTTP service - Access logs

Ballerina allows enabling HTTP access logs, which can be used to record the HTTP requests handled by the application. HTTP access logs are disabled by default. Set `console=true` under `ballerina.http.accessLogConfig` in the `Config.toml` file to enable them. Additionally, the `path` field can be used to specify the file path to save the access logs.

::: code http_access_logs.bal :::

## Prerequisites
- Populate the `Config.toml` file with the access log configurations.

::: code Config.toml :::

Run the service as follows.

::: out http_access_logs.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_access_logs.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http:AccessLogConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/AccessLogConfiguration)
- [HTTP service access log - Specification](/spec/http/#824-access-log)
