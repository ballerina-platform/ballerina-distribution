# UDP client - Send/Receive datagram with connection

Ballerina UDP ConnectClient can be used to interact with a service served over UDP protocol. When using the ConnectClient, once connected, data may not be received from or sent to any other address. Use the Ballerina UDP ConnectClient to only receives data from, and sends data to, the given remote peer address. The client remains connected until it is explicitly disconnected or until it is closed.

::: code udp_connect_client.bal :::

## Prerequisites
- Run the UDP service given in the [Send/Receive datagram](/learn/by-example/udp-listener/) example.

Run the client program by executing the command below.

::: out udp_connect_client.out :::

## Related links
- [`udp:Client` client object - API documentation](https://lib.ballerina.io/ballerina/udp/latest/clients/Client)
- [UDP Client - Specification](/spec/udp/#3-client)
