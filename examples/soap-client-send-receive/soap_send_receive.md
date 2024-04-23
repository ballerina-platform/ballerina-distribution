# SOAP client - Send/Receive

The `soap` module provides APIs to connect to a SOAP endpoint which currently supports SOAP 1.1 and 1.2 versions. Users can specify the version when importing the `soap` module. The `sendReceive()` API will send a request to a SOAP endpoint and binds the response to the one of the `xml` or `mime:Entity[]` data types determined by the user. The `sendOnly()` API only sends a request to a SOAP endpoint.

::: code soap_send_receive.bal :::

Run the program by executing the following command.

::: out soap_send_receive.out :::

## Related links

- [`soap` module - API documentation](https://central.ballerina.io/ballerina/soap/)
- [`soap` Client - Specification](/spec/soap/#21-client)
