# gRPC service - Basic authentication LDAP user store

The `grpc:Service` can be secured with basic authentication and additionally, scopes can be added to enforce authorization. This can be achieved by validating the basic authentication token sent in the `Authorization` metadata with the LDAP server. This server stores the usernames and passwords for the authentication and the scopes for the authorization.

To enable authentication, set the LDAP-related configurations to the `ldapUserStoreConfig` field. To enable authorization, set the scopes to the `scopes` field. Both configurations must be given as part of the service configuration. A `grpc:UnauthenticatedError` is sent to the client when the authentication fails, and a `grpc:PermissionDeniedError` is sent to the client when the authorization fails. Use this to authenticate and authorize requests based on LDAP user stores.

   ::: code grpc_service_basic_auth_ldap_user_store.bal :::

Setting up the service is the same as setting up the simple RPC service with additional configurations. For information on implementing the service, see [gRPC service - Simple RPC](/learn/by-example/grpc-service-simple/).

## Prerequisites
- Run the LDAP server.

Run the service by executing the command below.

   ::: out grpc_service_basic_auth_ldap_user_store.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Basic authentication](/learn/by-example/grpc-client-basic-auth).

## Related links
- [`grpc:LdapUserStoreConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/LdapUserStoreConfig)
- [gRPC service basic authentication LDAP user store - Specification](/spec/grpc/#5112-service---basic-auth---ldap-user-store)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
