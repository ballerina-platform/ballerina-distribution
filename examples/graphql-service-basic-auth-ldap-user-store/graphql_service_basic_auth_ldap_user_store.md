# GraphQL service - Basic authentication LDAP user store

The `graphql:Service` can be secured with basic authentication and additionally, scopes can be added to enforce authorization. It validates the basic authentication token sent in the `Authorization` header with the LDAP server. This server stores the usernames and passwords for the authentication and the scopes for the authorization. To engage authentication, set the LDAP server configurations to the `ldapUserStoreConfig` field. To engage authorization, set scopes to the `scopes` field. Both configurations must be given as part of the `@graphql:ServiceConfig` annotation.

::: code graphql_service_basic_auth_ldap_user_store.bal :::

Run the service by executing the command below.

::: out graphql_service_basic_auth_ldap_user_store.server.out :::

>**Tip:** You can invoke the above service via the [GraphQL client - Basic authentication](/learn/by-example/graphql-client-security-basic-auth/) example.

## Related links
- [`graphql:ServiceConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/annotations#ServiceConfig)
- [`graphql:LdapUserStoreConfigWithScopes` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/LdapUserStoreConfigWithScopes)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [GraphQL service basic authentication - LDAP user store - Specification](/spec/graphql/#11112-basic-authentication---ldap-user-store)
