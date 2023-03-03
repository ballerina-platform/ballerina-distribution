# GraphQL service - Basic authentication file user store

The `graphql:Service` can be secured with basic authentication and additionally, scopes can be added to enforce authorization. It validates the basic authentication token sent in the `Authorization` header against the provided configurations in the `Config.toml` file. The file stores the usernames and passwords for the authentication and the scopes for the authorization. To engage authentication set the default values to the `fileUserStoreConfig` field and add the `Config.toml` file next to the service file. To enable authorization, set the scopes to the `scopes` field. Both configurations must be given as part of the `@graphql:ServiceConfig` annotation.

A `graphql:Error` response is sent to the client when the authentication or authorization fails. Use this to authenticate and authorize requests based on user stores.

::: code graphql_service_basic_auth_file_user_store.bal :::

>**Info:** As a prerequisite to running the service, populate the `Config.toml` file correctly with the user information as shown below.

::: code Config.toml :::

Run the service by executing the command below.

::: out graphql_service_basic_auth_file_user_store.server.out :::

>**Tip:** You can invoke the above service via the [GraphQL client - Basic authentication](/learn/by-example/graphql-client-security-basic-auth/) example.

## Related links
- [`graphql:ServiceConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#ServiceConfig)
- [`graphql:FileUserStoreConfigWithScopes` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest#FileUserStoreConfigWithScopes)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [GraphQL service basic authentication - file user store - Specification](/spec/graphql/#12111-basic-authentication---file-user-store)
