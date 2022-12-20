# HTTP service - Redirects

The `http:Request` is redirected by sending a redirect response with the `Location` header by the `http:Service`. This is done by invoking the `redirect` method of `http:Caller` which results in the response containing the specified status code and the `Location` header.

::: code http_service_redirects.bal :::

Run the service as follows.

::: out http_service_redirects.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

>**Tip:** You may invoke the service via [Redirect client](../http-client-redirects/) example.

::: out http_service_redirects.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service caller - specification](/spec/http/#2341-httpcaller)
