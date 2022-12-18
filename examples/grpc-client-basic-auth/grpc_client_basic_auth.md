# gRPC client - Basic authentication

The `grpc:Client` can connect to a service that is secured with basic authentication by enriching the client metadata with the `Authorization: Basic <token>` header. The username and password for basic authentication can be specified in the `auth` field of the client configuration.

   ::: code grpc_client_basic_auth.bal :::

Setting up the client is the same as setting up the simple RPC client with additional configurations. For information on implementing the client, see [gRPC client - Simple RPC](/learn/by-example/grpc-client-simple/).

## Prerequisites
- Run the gRPC service given in the [gRPC service - Basic authentication file user store](/learn/by-example/grpc-service-basic-auth-file-user-store/) or [gRPC service - Basic authentication LDAP user store](/learn/by-example/grpc-service-basic-auth-ldap-user-store/) examples.

Run the client by executing the command below.

   ::: out grpc_client_basic_auth.out :::

## Related links
- [`grpc:ClientAuthConfig` type - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/types#ClientAuthConfig)
- [gRPC client basic authentication - Specification](/spec/grpc/#5115-client---basic-auth)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
