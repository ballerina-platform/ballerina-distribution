# gRPC client - SSL/TLS

The `grpc:Client` can be configured to communicate through HTTPS by providing a certificate file. The certificate can be provided through the `secureSocket` field of the client configuration. Use this to secure the communication between the client and the server.

   ::: code grpc_client_ssl_tls.bal :::

Setting up the client is the same as setting up the simple RPC client with additional configurations. For information on implementing the client, see [gRPC client - Simple RPC](/learn/by-example/grpc-client-simple/).

## Prerequisites
- Run the gRPC service given in the [gRPC service - SSL/TLS](/learn/by-example/grpc-service-ssl-tls/) example.

Run the client by executing the command below.

   ::: out grpc_client_ssl_tls.out :::

## Related links
- [`grpc:ClientSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/ClientSecureSocket)
- [gRPC client SSL/TLS - Specification](/spec/grpc/#52-ssltls-and-mutual-ssl)
