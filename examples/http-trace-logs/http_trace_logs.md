# HTTP service - Trace logs

Ballerina allows enabling HTTP trace logs, which can be used to monitor the HTTP traffic that goes in and out of the application. HTTP trace logs are disabled by default. Set the log level to `TRACE` using the `-Cballerina.http.traceLogConsole=true` runtime argument to enable them. 

::: code http_trace_logs.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the service as follows with the runtime argument to enable trace logs.

::: out http_trace_logs.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_trace_logs.client.out :::

Additionally, the `Config.toml` file supports further configurations for advanced use cases, such as configuring the `hostname` and `port` of a socket service to publish the trace logs and writing trace logs to a file using the `file` configuration, which allows specifying the log file location and rotation settings.

::: code Config.toml :::

## Related links
- [`http:TraceLogAdvancedConfiguration` record](https://lib.ballerina.io/ballerina/http/latest#TraceLogAdvancedConfiguration)
- [HTTP service trace log - Specification](/spec/http/#823-trace-log)
