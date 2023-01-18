# gRPC service - Basic authentication LDAP user store

A gRPC service/resource can be secured with Basic authentication and by enforcing authorization optionally. Then, it validates the Basic Auth token sent in the `Authorization` metadata against the provided configurations. This reads data from the configured LDAP. This stores usernames, passwords for authentication, and scopes for authorization.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s).

In the authorization phase, the scopes of the service/resource are compared against the scope included in the user store for at least one match between the two sets.

   ::: code grpc_service_basic_auth_ldap_user_store.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

Execute the command below to run the service.

   ::: out grpc_service_basic_auth_ldap_user_store.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Basic authentication](/learn/by-example/grpc-client-basic-auth).

## Related links
- [`grpc:LdapUserStoreConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/LdapUserStoreConfig)
- [gRPC service basic authentication LDAP user store - Specification](/spec/grpc/#5112-service---basic-auth---ldap-user-store)
- [`auth` package - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
