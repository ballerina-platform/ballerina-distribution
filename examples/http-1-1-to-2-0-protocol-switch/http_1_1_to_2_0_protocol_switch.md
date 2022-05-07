# HTTP 1.1 to 2.0 protocol switch

The HTTP service receives a message over the HTTP/1.1 protocol and forwards it
to another service over the HTTP/2.0 protocol.<br/><br/>
For more information on the underlying module, 
see the [HTTP module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code ./examples/http-1-1-to-2-0-protocol-switch/http_1_1_to_2_0_protocol_switch.bal :::

::: out ./examples/http-1-1-to-2-0-protocol-switch/http_1_1_to_2_0_protocol_switch.client.out :::

::: out ./examples/http-1-1-to-2-0-protocol-switch/http_1_1_to_2_0_protocol_switch.server.out :::