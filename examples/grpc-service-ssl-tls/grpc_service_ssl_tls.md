# gRPC service - SSL/TLS

The `grpc:Listener` can be configured to communicate with a gRPC client via SSL/TLS by providing a certificate file and a private key file. The certificate and the key can be provided through the `secureSocket` field of the listener configuration. Use this to secure the communication and data transfer between the server and the client.

   ::: code grpc_service_ssl_tls.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Simple RPC](/learn/by-example/grpc-service-simple/) to implement the service used below.

Run the service by executing the command below.

   ::: out grpc_service_ssl_tls.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - SSL/TLS](/learn/by-example/grpc-client-ssl-tls/).

## Related links
- [`grpc:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/ListenerSecureSocket)
- [gRPC service SSL/TLS - Specification](/spec/grpc/#52-ssltls-and-mutual-ssl)
