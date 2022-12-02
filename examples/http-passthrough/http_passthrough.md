# HTTP service - Passthrough

The passthrough sample exhibits the process of an HTTP client connector. The 'Echo Service' is used as a sample backend.

::: code http_passthrough.bal :::

Run the service as follows.

::: out http_passthrough.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out http_passthrough.client.out :::

## Related links
- [`forward()` - API documentation](https://lib.ballerina.io/ballerina/http/latest/clients/Client#forward)
- [HTTP service forward method - Specification](/spec/http/#2424-forwardexecute-methods)
