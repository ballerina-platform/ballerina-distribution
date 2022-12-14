# gRPC service - Basic authentication LDAP user store

The `grpc:Service` can be secured with basic authentication and optionally by enforcing authorization. This can be achieved by validating the basic authentication token sent in the `Authorization` metadata with the LDAP server. This server stores the usernames and passwords for the authentication and the scopes for the authorization. A `grpc:Service` can configure the scopes it needs for authorization in the `auth` field of the `@grpc:ServiceConfig` annotation. A `grpc:UnauthenticatedError` is sent to the client when the authentication fails, and a `grpc:PermissionDeniedError` is sent to the client when the authorization fails. Use this to authenticate and authorize requests based on LDAP user stores.

   ::: code grpc_service_basic_auth_ldap_user_store.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

## Prerequisites
- Run the LDAP server.

Run the service by executing the command below.

   ::: out grpc_service_basic_auth_ldap_user_store.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Basic authentication](/learn/by-example/grpc-client-basic-auth).

## Related links
- [`grpc:LdapUserStoreConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/LdapUserStoreConfig)
- [gRPC service basic authentication LDAP user store - Specification](/spec/grpc/#5112-service---basic-auth---ldap-user-store)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
