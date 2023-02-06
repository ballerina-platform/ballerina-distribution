# HTTP service - Redirects

Redirection is important to direct requests to the correct endpoints if the called one is not existing or moved. The HTTP specification provides standard status codes to notify such situation to the caller. The HTTP service responds with `redirect` status code response along with the `location` header of the new endpoint. This can be done using the `http:StatusCodeResponse` records.

::: code http_service_redirects.bal :::

## Prerequisites
- Run the HTTP service given in the [Basic REST service](/learn/by-example/http-basic-rest-service/) example.

Run the service as follows.

::: out http_service_redirects.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

>**Tip:** You may invoke the service via [Redirect client](../http-client-redirects/) example.

::: out http_service_redirects.client.out :::

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service caller - specification](/spec/http/#2341-httpcaller)
