# HTTP service - Basic authentication LDAP user store

The `http:Service` can be secured with basic authentication and additionally, scopes can be added to enforce authorization. It validates the basic authentication token sent in the `Authorization` header with the LDAP server. This server stores the usernames and passwords for the authentication and the scopes for the authorization. To engage authentication, set the LDAP related configurations to the `ldapUserStoreConfig` field. To engage authorization, set scopes to the `scopes` field. Both configurations must be given as part of the service configuration.

A `401 Unauthorized` response is sent to the client when the authentication fails, and a `403 Forbidden` response is sent to the client when the authorization fails. Use this to authenticate and authorize requests based on LDAP user stores. Furthermore, the authentication and authorization configurations can be overwritten at the resource level using the `@http:ResourceConfig` annotation.

::: code http_service_basic_authentication_ldap_user_store.bal :::

## Prerequisites
- Run the LDAP server.

Run the service by executing the command below.

::: out http_service_basic_authentication_ldap_user_store.server.out :::

>**Tip:** You can invoke the above service via the [Basic authentication client](/learn/by-example/http-client-basic-authentication) example.

## Related links
- [`http:LdapUserStoreConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest#LdapUserStoreConfig)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [HTTP service listener basic authentication LDAP user store - Specification](/spec/http/#9112-listener---basic-auth---ldap-user-store)
