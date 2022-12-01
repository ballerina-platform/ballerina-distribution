# HTTP service - HTTP/2.0 to HTTP/1.1 protocol switch

The HTTP client is configured to run over the HTTP/1.1 protocol. This client will only send requests over the HTTP/1.1 protocol.  

::: code http_2_0_to_1_1_downgrade_client.bal :::

Run the service by executing the following command.

::: out http_2_0_to_1_1_protocol_switch.server.out :::

## Related links
- [`http` package - API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`http listener` - specification](https://ballerina.io/spec/http/#21-listener)
