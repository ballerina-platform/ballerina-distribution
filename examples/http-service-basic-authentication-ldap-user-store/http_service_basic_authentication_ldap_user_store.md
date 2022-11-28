# HTTP service - Basic authentication LDAP user store

An HTTP service/resource can be secured with basic authentication and by enforcing authorization optionally. Then, it validates the Basic Auth token sent in the `Authorization` header against the provided configurations. This reads data from the configured LDAP. This stores usernames, passwords for authentication, and scopes for authorization. Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). In the authorization phase, the scopes of the service/resource are compared against the scope included in the user store for at least one match between the two sets.

::: code http_service_basic_authentication_ldap_user_store.bal :::

Run the service by executing the command below.

::: out http_service_basic_authentication_ldap_user_store.server.out :::

>**Info:** You can invoke the above service via the [Basic authentication client](/learn/by-example/http-client-basic-authentication).

## Related links
- [`http:LdapUserStoreConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/LdapUserStoreConfig)
- [`auth` package API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [`Listener basic authentication LDAP user store` - specification](https://ballerina.io/spec/http/#9112-listener---basic-auth---ldap-user-store)
