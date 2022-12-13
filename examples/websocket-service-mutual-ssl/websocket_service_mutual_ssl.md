# WebSocket service - Mutual SSL

A `websocket:Listener` with enabled mutual SSL(mTLS) allows you to expose a connection secured with mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity. A `websocket:Listener` secured with mutual SSL is created by providing the `secureSocket` configurations which require the word `require` as the `verifyClient`, the server's public certificate as the `certFile`, server's private key as the `keyFile` and the client's certificate as the `cert`. Use this to secure the WebSocket connection over mutual SSL.

::: code websocket_service_mutual_ssl.bal :::

Run the service by executing the command below.

::: out websocket_service_mutual_ssl.server.out :::

>**Tip:** You can invoke the above service via the [Mutual SSL/TLS client](/learn/by-example/websocket-client-mutual-ssl/).

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [WebSocket SSL/TLS - Specification](/spec/websocket/#5-securing-the-websocket-connections)

