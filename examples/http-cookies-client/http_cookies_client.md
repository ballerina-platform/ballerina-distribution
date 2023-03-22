# HTTP client - Cookies

HTTP cookies can track, personalize, and manage the session between the `http:Client` and service. Cookie client behavior is enabled using the `http:ClientConfiguration`. If the cookie-enabled client receives a response with a cookie, the subsequent requests are sent along with the same cookie. Therefore the same session id is passed back to the service to retrieve the previous state. This is useful to maintain stateful interaction.

::: code http_cookies_client.bal :::

## Prerequisites
- Run the HTTP service given in the [Cookies service](/learn/by-example/http-cookies-service/) example.

Run the client program by executing the following command.

::: out http_cookies_client.out :::

## Related links
- [`http:Cookie` - API documentation](https://lib.ballerina.io/ballerina/http/latest#Cookie)
- [HTTP service cookie - Specification](/spec/http/#2416-cookie)
