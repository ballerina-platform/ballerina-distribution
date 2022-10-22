# Redirects

The HTTP client supports redirection. To follow redirects when calling an external HTTP server using the Ballerina HTTP client connector, set `followRedirect` to `true`.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) 
and [specification](https://ballerina.io/spec/http/#2413-redirect).

::: code http_redirects.bal :::

Run the service as follows.

::: out http_redirects.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_redirects.client.out :::

