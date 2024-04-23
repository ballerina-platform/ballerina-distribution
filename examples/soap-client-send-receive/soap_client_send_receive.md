# SOAP client - Send/Receive

The `soap` module provides APIs to connect to a SOAP endpoint that supports SOAP 1.1 or 1.2 versions. Users can specify the version when importing the `soap` module. The `sendReceive()` API will send a request to a SOAP endpoint and bind the response to one of the `xml` or `mime:Entity[]` data types determined by the user. The `sendOnly()` API only sends a request to a SOAP endpoint.

The example demonstrates connecting to a live SOAP endpoint that executes basic arithmetic operations. Here a SOAP envelope is constructed including necessary numerical values, transmits to the SOAP endpoint, and receives the response in the `xml` format.

::: code soap_client_send_receive.bal :::

Run the program by executing the following command.

::: out soap_client_send_receive.out :::

## Related links

- [`soap` module - API documentation](https://central.ballerina.io/ballerina/soap/)
- [`soap` Client - Specification](/spec/soap/#21-client)
