# HTTP service - Redirects

The `http:Client` supports redirection. If the `http:Response` contains a `redirect` status code with `Location` header, the client internally calls the respective endpoint and returns the successful response. To enable redirection, set `followRedirect` to `true` in the client config.

::: code http_service_redirects.bal :::

Run the service as follows.

::: out http_service_redirects.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

>**Tip:** You may invoke the service via [Redirect client](../http-client-redirects/) example.

::: out http_service_redirects.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service caller - specification](/spec/http/#2341-httpcaller)
