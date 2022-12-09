# UDP client - Send/Receive datagram

Ballerina UDP client can be used to interact with a service served over UDP protocol. It is used to connect and send data to a specific remote host. Use this client to establish low latency connections for time critical transmissions where data loss is acceptable.    

::: code udp_client.bal :::

## Prerequisites
- Run the UDP service given in the [Send/Receive datagram](/learn/by-example/udp-listener/) example.

Run the client program by executing the command below.

::: out udp_client.out :::

## Related links
- [`udp:Client` client object - API documentation](https://lib.ballerina.io/ballerina/udp/latest/clients/Client)
- [UDP Client - Specification](/spec/udp/#3-client)
