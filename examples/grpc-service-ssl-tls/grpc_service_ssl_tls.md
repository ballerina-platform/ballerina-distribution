# gRPC service - SSL/TLS

You can use the gRPC listener to connect to or interact with a gRPC client secured with SSL/TLS. Provide the `grpc:ListenerSecureSocket` configurations to the server to expose an HTTPS connection over HTTP/2.

   ::: code grpc_service_ssl_tls.bal :::

Execute the command below to run the service.
Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [unary RPC service](/learn/by-example/grpc-service-unary/) to implement the service used below.

   ::: out grpc_service_ssl_tls.server.out :::

>**Tip:** You can invoke the above service via the [sample SSL/TLS client](/learn/by-example/grpc-client-ssl-tls/).

## Related links
- [`grpc:ListenerSecureSocket` - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/ListenerSecureSocket)
- [SSL/TLS - specification](/spec/grpc/#52-ssltls-and-mutual-ssl)
