# Client - SSL/TLS

You can use the gRPC client to connect or interact with a gRPC listener secured with SSL/TLS. Provide the `grpc:ClientSecureSocket` configurations to the client to initiate an HTTPS connection over HTTP/2.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

>**Info:** Setting up the client is the same as setting up the simple RPC client with additional configurations. You can refer to the [simple RPC client](/learn/by-example/grpc-client-simple/) to implement the client used below.

>**Tip:** You may need to change the trusted certificate file path in the code below. 
   
   ::: code grpc_client_ssl_tls.bal :::

Execute the command below to run the client.

>**Info:** As a prerequisite to running the client, start a [sample service secured with SSL/TLS](earn/by-example/grpc-service-ssl-tls/).

   ::: out grpc_client_ssl_tls.out :::
