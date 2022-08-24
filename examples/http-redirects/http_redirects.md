# Redirects

The HTTP client supports redirection. To follow redirects when calling an external HTTP server using the Ballerina HTTP client connector, set `followRedirect` to `true`.

For more information on the underlying module, see the [HTTP module](https://lib.ballerina.io/ballerina/http/latest/).

::: code http_redirects.bal :::

Run the service as follows.

::: out http_redirects.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_redirects.client.out :::

