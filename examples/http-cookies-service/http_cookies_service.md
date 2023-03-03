# HTTP service - Cookies

HTTP cookies can track, personalize, and manage the session in the service. The cookies can be accessed from the `getCookies` method of the `http:Request`. Setting cookies back in the response is done by the `addCookie` method of the `http:Response`. This is useful for services to maintain the state.

::: code http_cookies_service.bal :::

Run the service as follows.

::: out http_cookies_service.out :::

>**Tip:** You can invoke the above service via the [Cookies client](/learn/by-example/http-cookies-client/) example.

## Related links
- [`http:Cookie` - API documentation](https://lib.ballerina.io/ballerina/http/latest#Cookie)
- [HTTP service cookie - Specification](/spec/http/#2416-cookie)
