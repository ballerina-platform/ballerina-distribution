# Service - SSL/TLS

You can use the gRPC listener to connect to or interact with a gRPC client secured with SSL/TLS. Provide the `grpc:ListenerSecureSocket` configurations to the server to expose an HTTPS connection over HTTP/2.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

>**Info:** Setting up the service is the same as setting up the simple RPC service with additional configurations. You can refer to the [simple RPC service](/learn/by-example/grpc-service-simple/) to implement the service used below.

>**Tip** You may need to change the certificate file path and private key file path in the code below.

   ::: code grpc_service_ssl_tls.bal :::

Execute the command below to run the service.

   ::: out grpc_service_ssl_tls.server.out :::

>**Info:** You can invoke the above service via the [sample SSL/TLS client](/learn/by-example/grpc-client-ssl-tls/).
