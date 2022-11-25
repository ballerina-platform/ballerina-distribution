# gRPC service - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

   ::: code grpc_service_mutual_ssl.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [unary RPC service](/learn/by-example/grpc-service-unary/) to implement the service used below.

Execute the command below to run the service.

   ::: out grpc_service_mutual_ssl.server.out :::

>**Tip:** You can invoke the above service via the [sample Mutual SSL client](/learn/by-example/grpc-client-mutual-ssl/).

## Related links
- [`grpc:ListenerSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/ListenerSecureSocket)
- [Mutual SSL - specification](/spec/grpc/#52-ssltls-and-mutual-ssl)
