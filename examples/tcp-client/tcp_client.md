# TCP client - Send/Receive bytes

The `tcp:Client` connects to a given TCP server socket, and then sends and receives byte streams. A TCP client is created by giving the IP and port number. Once connected, `writeBytes` and `readBytes` synchronous methods are used to send and receive byte streams. Since, they are synchronous methods often used in two different strands. Use this to interact with TCP servers or implement high level protocols based on TCP.

::: code tcp_client.bal :::

## Prerequisites
- Run the TCP service given in the [Send/Receive bytes](/learn/by-example/tcp-listener/) example.

Run the client program by executing the command below.

::: out tcp_client.out :::

## Related links
- [`tcp:Client` client object - API documentation](https://lib.ballerina.io/ballerina/tcp/latest/clients/Client)
- [TCP Client - Specification](/spec/tcp/#4-client)
