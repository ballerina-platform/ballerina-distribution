# UDP client - Send/Receive datagram with connection

The ConnectClient is configured so that it only receives data from, and sends data to, the given remote peer address. Once connected, data may not be received from or sent to any other address. 

The client remains connected until it is explicitly disconnected or until it is closed. This sample demonstrates how to send data to a connected server and print the echoed response.

::: code udp_connect_client.bal :::

## Prerequisites
- Run the UDP service given in the [Send/Receive datagram](/learn/by-example/udp-listener/) example.

Run the client program by executing the command below.

::: out udp_connect_client.out :::

## Related links
- [`udp:Client` client object - API documentation](https://lib.ballerina.io/ballerina/udp/latest/clients/Client)
- [`udp:Client` - Specification](/spec/udp/#3-client)
