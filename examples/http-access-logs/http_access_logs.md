# Access logs

Ballerina supports HTTP access logs for HTTP services. The access log format used is the combined log format.
To enable access logs, set `console=true` under the `ballerina.http.accessLogConfig` in the `Config.toml` file.
Also, the `path` field can be used to specify the file path to save the access logs.<br/><br/>
For more information on the underlying module,
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_access_logs.bal :::

::: out http_access_logs.client.out :::

::: out http_access_logs.server.out :::