# gRPC client - Basic authentication

A client, which is secured with Basic authentication can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Basic <token>` header by passing the `grpc:CredentialsConfig` for the `auth` configuration of the client.

   ::: code grpc_client_basic_auth.bal :::

Execute the command below to run the client.
Setting up the client is the same as setting up the unary RPC client with additional configurations. You can refer to the [unary RPC client](/learn/by-example/grpc-client-unary/) to implement the client used here.

>**Tip:** As a prerequisite to running the client, start the [Basic Auth file user store service](/learn/by-example/grpc-service-basic-auth-file-user-store/) or [Basic Auth LDAP user store service](/learn/by-example/grpc-service-basic-auth-ldap-user-store/).

   ::: out grpc_client_basic_auth.out :::

## Related links
- [Basic authentication - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/types#ClientAuthConfig)
- [Basic authentication - specification](/spec/grpc/#5115-client---basic-auth)
- [`auth` package - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
