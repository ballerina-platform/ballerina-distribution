# gRPC client - Mutual SSL

The `grpc:Client` allows opening up a connection secured with mutual SSL (mTLS), which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity. The `grpc:Client` secured with mutual SSL is created by providing the `secureSocket` configurations, which require the client's public certificate as the `certFile`, the client's private key as the `keyFile`, and the server's certificate as the `cert`. Use this to interact with mTLS-encrypted gRPC servers.

   ::: code grpc_client_mutual_ssl.bal :::

Setting up the client is the same as setting up the simple RPC client with additional configurations. For information on implementing the client, see [gRPC client - Simple RPC](/learn/by-example/grpc-client-simple/).

## Prerequisites
- Run the gRPC service given in the [gRPC service - Mutual SSL](/learn/by-example/grpc-service-mutual-ssl/) example.

Run the client by executing the command below.

   ::: out grpc_client_mutual_ssl.out :::

## Related links
- [`grpc:ClientSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/ClientSecureSocket)
- [gRPC client mutual SSL - Specification](/spec/grpc/#52-ssltls-and-mutual-ssl)
