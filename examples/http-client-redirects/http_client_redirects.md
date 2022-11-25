# HTTP client - Redirects

The HTTP client supports redirection. To follow redirects when calling an external HTTP server using the Ballerina HTTP client connector, set `followRedirect` to `true`.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) and [specification](https://ballerina.io/spec/http/#2413-redirect).

::: code http_client_redirects.bal :::

## Prerequisites
- Start a [Redirect service](learn/by-example/http-service-redirects/).

Run the client program by executing the following command.

::: out http_client_redirects.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Redirect` - specification](https://ballerina.io/spec/http/#2413-redirect)
