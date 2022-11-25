# HTTP service - Trace logs

The HTTP trace logs can be used to monitor the HTTP traffic that goes in and out of Ballerina. To enable trace logs, the log level has to be set to `TRACE` using the `-Cballerina.http.traceLogConsole=true` runtime argument. The configurations can be set in the `Config.toml` file for advanced use cases such as specifying the file path to save the trace logs and specifying the hostname and port of a socket service to publish the trace logs.

::: code http_trace_logs.bal :::

Run the service as follows.

::: out http_trace_logs.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_trace_logs.client.out :::

## Related links
- [`http` - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Trace log` - specification](https://ballerina.io/spec/http/#823-trace-log)
