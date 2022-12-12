# TCP service - Send/Receive bytes

A TCP listener opens up a TCP socket via a specific port. A listener is created by giving the port number. Then it is attached to a TCP service that accepts and serves connections from TCP clients. The `onBytes` remote function is invoked once the content is received from the client. The `onError` and `onClose` remote functions get invoked in an erroneous situation and when the connection is closed respectively. Use a TCP service to establish connections and communicate over TCP protocol or implement high level protocols based on TCP. 

::: code tcp_listener.bal :::

Run the service by executing the command below.

::: out tcp_listener.out :::

>**Tip:** You can invoke the above service via the [TCP client](/learn/by-example/tcp-client/).

## Related links
- [`tcp` package - API documentation](https://lib.ballerina.io/ballerina/tcp/latest)
- [TCP service  - Specification](/spec/tcp/#3-service-types)
