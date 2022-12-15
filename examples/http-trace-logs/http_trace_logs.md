# HTTP service - Trace logs

Ballerina allows enabling HTTP trace logs, which can be used to monitor the HTTP traffic that goes in and out of the application. HTTP trace logs are disabled by default, and to enable them, the log level has to be set to `TRACE` using the `-Cballerina.http.traceLogConsole=true` runtime argument. 

::: code http_trace_logs.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the service as follows with the runtime argument to enable trace logs.

::: out http_trace_logs.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_trace_logs.client.out :::

Additionally, the following configurations can be added to the `Config.toml` file for advanced use cases, such as specifying the file path to save the trace logs to a file and the hostname and port of a socket service to publish the trace logs.

::: code Config.toml :::

## Related links
- [`http:TraceLogAdvancedConfiguration` record](https://lib.ballerina.io/ballerina/http/latest/records/TraceLogAdvancedConfiguration)
- [HTTP service trace log - Specification](/spec/http/#823-trace-log)
