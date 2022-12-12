# UDP client - Send/Receive datagram with connection

The `udp:ConnectClient` connects to a UDP server socket, and then sends and receives datagrams. When connected, data may not be received from or sent to any other address. A UDP `ConnectClient` is created by giving the `remoteHost` and `remotePort`. Once connected, `writeBytes` and `readBytes` synchronous methods are used to send and receive byte streams. Since, they are synchronous methods often used in two different strands. The client remains connected until it is explicitly disconnected or until it is closed. Use this to interact with UDP servers or implement low latency connections for time critical transmissions where data loss is acceptable.

::: code udp_connect_client.bal :::

## Prerequisites
- Run the UDP service given in the [Send/Receive datagram](/learn/by-example/udp-listener/) example.

Run the client program by executing the command below.

::: out udp_connect_client.out :::

## Related links
- [`udp:Client` client object - API documentation](https://lib.ballerina.io/ballerina/udp/latest/clients/Client)
- [UDP Client - Specification](/spec/udp/#3-client)
