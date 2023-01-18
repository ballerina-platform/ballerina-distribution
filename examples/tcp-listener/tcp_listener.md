# TCP service - Send/Receive bytes

The `tcp:Service` allows opening up a TCP socket via a `tcp:Listener`. A `tcp:Listener` is created by giving the port number, to which `tcp:Service` is attached. The listener accepts and serves connections from TCP clients. The `onBytes` remote method is invoked once the content is received from the client. The `onError` and `onClose` remote methods get invoked in an erroneous situation and when the connection is closed respectively. Use a TCP service to establish connections and communicate over TCP protocol or implement high level protocols based on TCP. 

::: code tcp_listener.bal :::

Run the service by executing the command below.

::: out tcp_listener.out :::

>**Tip:** You can invoke the above service via the [TCP client](/learn/by-example/tcp-client/).

## Related links
- [`tcp` module - API documentation](https://lib.ballerina.io/ballerina/tcp/latest)
- [TCP service  - Specification](/spec/tcp/#3-service-types)
