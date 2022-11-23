# HTTP 1.1 to 2.0 protocol switch

The HTTP service receives a message over the HTTP/1.1 protocol and forwards it to another service over the HTTP/2.0 protocol.

::: code http_1_1_to_2_0_protocol_switch.bal :::

Run the service by executing the following command.

::: out http_1_1_to_2_0_protocol_switch.server.out :::

Invoke the service as follows.

::: out http_1_1_to_2_0_protocol_switch.client.out :::

## Related links
- [`http` package API documentation](https://lib.ballerina.io/ballerina/http/latest/)
- [`Protocol upgrade` - specification](https://ballerina.io/spec/http/#10-protocol-upgrade)
