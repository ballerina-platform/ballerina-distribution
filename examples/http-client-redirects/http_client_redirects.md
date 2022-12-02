# HTTP client - Redirects

The HTTP client supports redirection. To follow redirects when calling an external HTTP server using the Ballerina HTTP client connector, set `followRedirect` to `true`.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) and [specification](/spec/http/#2413-redirect).

::: code http_client_redirects.bal :::

## Prerequisites
- Run the HTTP service given in the [Redirect service](/learn/by-example/http-service-redirects/) example.

Run the client program by executing the following command.

::: out http_client_redirects.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client redirect - Specification](/spec/http/#2413-redirect)
