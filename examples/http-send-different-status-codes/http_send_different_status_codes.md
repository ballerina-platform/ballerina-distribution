# REST service - Send different status codes

The subtypes of the `http:StatusCodeResponse` record represent different HTTP status code responses. Returning them from the resource function results in the relevant HTTP status code response.
To send a non-entity body response, use the relevant constant value declared in the `http` module. These constant values can be directly returned from the resource method as long as the relevant return type is specified in the resource function signature.
Use these when you want to send different status code responses without a body and headers.

::: code http_send_different_status_codes.bal :::

Run the service as follows.

::: out http_send_different_status_codes.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_send_different_status_codes.client.out :::

>**Tip:** You can invoke the above service via the [Send request/Receive response client](/learn/by-example/http-client-send-request-receive-response/).

## Related links
- [`http` module - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [HTTP service status code response - Specification](/spec/http/#2351-status-code-response)
