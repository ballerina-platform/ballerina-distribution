# UDP service - Send/Receive datagram

The `udp:Listener` opens up a UDP socket via a specific port. A `udp:Listener` is created by giving the port number. Then it is attached to a UDP service that accepts and serves connections from UDP clients. The `onDatagram` remote function is invoked once the content is received from the client. Use a UDP service to establish connections and communicate over UDP protocol or implement low latency connections for time-critical transmissions where data loss is acceptable.

::: code udp_listener.bal :::

Run the service by executing the command below.

::: out udp_listener.out :::

>**Tip:** You can invoke the above service via the [UDP client](/learn/by-example/udp-client/).

## Related links
- [`udp` module - API documentation](https://lib.ballerina.io/ballerina/udp/latest)
- [UDP service - Specification](/spec/udp/#4-service)
