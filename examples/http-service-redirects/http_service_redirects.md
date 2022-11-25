# HTTP service - Redirects

The HTTP service provides redirection through `redirect()` method of `http:Caller`. The response contains the specified status code and the `Location` header.

::: code http_service_redirects.bal :::

Run the service as follows.

::: out http_service_redirects.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

>**Tip:** You may invoke the service via [Redirect client](../http-client-redirects/).

::: out http_service_redirects.client.out :::

## Related links
- [`http` - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http:Caller` - specification](https://ballerina.io/spec/http/#2341-httpcaller)
