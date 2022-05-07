# Redirects

The HTTP client supports redirection. To follow redirects when calling an external HTTP server using the Ballerina
HTTP client connector, set `followRedirect` to `true`.<br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code ./examples/http-redirects/http_redirects.bal :::

::: out ./examples/http-redirects/http_redirects.client.out :::

::: out ./examples/http-redirects/http_redirects.server.out :::