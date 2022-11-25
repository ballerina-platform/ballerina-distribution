# gRPC client - SSL/TLS

You can use the gRPC client to connect or interact with a gRPC listener secured with SSL/TLS. Provide the `grpc:ClientSecureSocket` configurations to the client to initiate an HTTPS connection over HTTP/2.
 
   ::: code grpc_client_ssl_tls.bal :::

Setting up the client is the same as setting up the unary RPC client with additional configurations. You can refer to the [unary RPC client](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Start the [sample service secured with SSL/TLS](/learn/by-example/grpc-service-ssl-tls/).

Execute the command below to run the client.

   ::: out grpc_client_ssl_tls.out :::

## Related links
- [`grpc:ClientSecureSocket` - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/ClientSecureSocket)
- [SSL/TLS - specification](/spec/grpc/#52-ssltls-and-mutual-ssl)
