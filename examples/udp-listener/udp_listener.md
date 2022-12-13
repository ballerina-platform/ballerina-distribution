# UDP service - Send/Receive datagram

The UDP service allows you to open up a UDP socket via a `udp:Listener`. A `udp:Listener` is created by giving the port number. Then a UDP service is attached to the listener that accepts and serves connections from UDP clients. The `onDatagram` remote function is invoked once the content is received from the client. Use a UDP service to establish connections and communicate over UDP protocol or implement low latency connections for time-critical transmissions where data loss is acceptable.

::: code udp_listener.bal :::

Run the service by executing the command below.

::: out udp_listener.out :::

>**Tip:** You can invoke the above service via the [UDP client](/learn/by-example/udp-client/).

## Related links
- [`udp` module - API documentation](https://lib.ballerina.io/ballerina/udp/latest)
- [UDP service - Specification](/spec/udp/#4-service)
