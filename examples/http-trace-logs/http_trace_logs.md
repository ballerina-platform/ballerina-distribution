# Trace logs

The HTTP trace logs can be used to monitor the HTTP traffic that goes in and out of Ballerina.
To enable trace logs, the log level has to be set to `TRACE` using the runtime argument:
<br> `-Cballerina.http.traceLogConsole=true`. <br>
The configurations can be set in the `Config.toml` file for advanced use cases such as specifying the file path
to save the trace logs and specifying the hostname and port of a socket service to publish the trace logs.<br/><br/>
For more information on the underlying module,
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_trace_logs.bal :::

::: out http_trace_logs.client.out :::

::: out http_trace_logs.server.out :::