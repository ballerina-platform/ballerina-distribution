# Client - SSL/TLS

You can use the WSS client to connect or interact with an WSS listener. Provide the `websocket:ClientSecureSocket` configurations to the client to initiate an WSS connection.

For more information on the underlying module, see the [`websocket` module](https://lib.ballerina.io/ballerina/websocket/latest/).

>**Tip:** You may need to change the trusted certificate file path in the code below.

::: code websocket_client_ssl_tls.bal :::

Run the client program by executing the command below.

::: out websocket_client_ssl_tls.out :::

>**Info:** As a prerequisite to running the client, start a [sample service secured with SSL/TLS](/learn/by-example/websocket-service-ssl-tls/).