# gRPC service - SSL/TLS

You can use the gRPC listener to connect to or interact with a gRPC client secured with SSL/TLS. Provide the `grpc:ListenerSecureSocket` configurations to the server to expose an HTTPS connection over HTTP/2.

   ::: code grpc_service_ssl_tls.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Simple RPC](/learn/by-example/grpc-service-simple/) to implement the service used below.

Execute the command below to run the service.

   ::: out grpc_service_ssl_tls.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - SSL/TLS](/learn/by-example/grpc-client-ssl-tls/).

## Related links
- [`grpc:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/ListenerSecureSocket)
- [gRPC service SSL/TLS - Specification](/spec/grpc/#52-ssltls-and-mutual-ssl)
