# UDP client - Send/Receive datagram

The `udp:Client` connects to a UDP server socket, and then sends and receives datagrams. A UDP client is created by optionally giving the address that the socket needs to bind and the timeout in seconds, which specifies the read timeout value. Once connected, `sendDatagram` and `receiveDatagram` synchronous methods are used to send and receive datagrams. Since, they are synchronous methods often used in two different strands. Use this to interact with UDP servers or implement low latency connections for time critical transmissions where data loss is acceptable. 

::: code udp_client.bal :::

## Prerequisites
- Run the UDP service given in the [Send/Receive datagram](/learn/by-example/udp-listener/) example.

Run the client program by executing the command below.

::: out udp_client.out :::

## Related links
- [`udp:Client` client object - API documentation](https://lib.ballerina.io/ballerina/udp/latest/clients/Client)
- [UDP Client - Specification](/spec/udp/#3-client)
