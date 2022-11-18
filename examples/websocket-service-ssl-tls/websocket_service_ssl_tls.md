# SSL/TLS service

You can use the WebSocket listener to connect to or interact with an WebSocket client. Provide the `websocket:ListenerSecureSocket` configurations to the server to expose an WSS connection.

For more information on the underlying module, see the [`websocket` module](https://lib.ballerina.io/ballerina/websocket/latest/).

>**Tip:** You may need to change the certificate file path and private key file path in the code below.

::: code websocket_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out websocket_service_ssl_tls.server.out :::

>**Info:** You can invoke the above service via the [sample SSL/TLS client](/learn/by-example/websocket-client-ssl-tls/).