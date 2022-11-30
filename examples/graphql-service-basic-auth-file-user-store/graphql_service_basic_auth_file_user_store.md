# GraphQL service - Basic authentication file user store

A GraphQL service can be secured with Basic authentication and optionally by enforcing authorization. Then, it validates the Basic authentication token sent in the `Authorization` header against the provided configurations. This reads data from a file, which has a TOML format. This stores the usernames, passwords for authentication, and scopes for authorization.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). In the authorization phase, the scopes of the service are compared against the scope included in the user store for at least one match between the two sets. The `Config.toml` file is used to store the usernames, passwords, and scopes. Each user can have a password and optionally assigned scopes as an array.

::: code graphql_service_basic_auth_file_user_store.bal :::

>**Info:** As a prerequisite to running the service, populate the `Config.toml` file correctly with the user information as shown below.

::: code Config.toml :::

Run the service by executing the command below.

::: out graphql_service_basic_auth_file_user_store.server.out :::

>**Tip:** You can invoke the above service via the [GraphQL client - Basic authentication](/learn/by-example/graphql-client-security-basic-auth/) example.

## Related links
- [`graphql:ServiceConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/annotations#ServiceConfig)
- [`graphql:FileUserStoreConfigWithScopes` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/FileUserStoreConfigWithScopes)
- [`auth` package - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [`graphql` basic authentication - file user store - Specification](/spec/graphql/#11111-basic-authentication---file-user-store)
