# Access logs

Ballerina supports HTTP access logs for HTTP services. The access log format used is the combined log format. To enable access logs, set `console=true` under the `ballerina.http.accessLogConfig` in the `Config.toml` file. Also, the `path` field can be used to specify the file path to save the access logs.

For more information on the underlying module, see the [HTTP module](https://lib.ballerina.io/ballerina/http/latest/).

::: code http_access_logs.bal :::

Run the service as follows.

::: out http_access_logs.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_access_logs.client.out :::

