# Client - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

For more information on the underlying module, see the [`websocket` module](https://lib.ballerina.io/ballerina/websocket/latest/).

>**Tip:** You may need to change the certificate file path, private key file path, and trusted certificate file path in the code below.

::: code websocket_client_mutual_ssl.bal :::

Run the client program by executing the command below.

>**Info:** As a prerequisite to running the client, start a [sample service secured with Mutual SSL](/learn/by-example/websocket-service-mutual-ssl/).

::: out websocket_client_mutual_ssl.out :::
