# HTTP client - Redirects

The `http:Client` supports redirection. If the `http:Response` contains a `redirect` status code with `Location` header, the client internally calls the respective endpoint and returns the successful response. To enable redirection, set `followRedirect` to `true` in the client config.

::: code http_client_redirects.bal :::

## Prerequisites
- Run the HTTP service given in the [Redirect service](/learn/by-example/http-service-redirects/) example.

Run the client program by executing the following command.

::: out http_client_redirects.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP client redirect - Specification](/spec/http/#2413-redirect)
