# HTTP service - Basic authentication file user store

The `http:Service` can be secured with basic authentication and additionally, scopes can be added to enforce authorization. It validates the basic authentication token sent in the `Authorization` header against the provided configurations in the `Config.toml` file. The file stores the usernames and passwords for the authentication and the scopes for the authorization. To engage authentication, set the default values for the `fileUserStoreConfig` field and add the `Config.toml` file next to the service file. To engage authorization, set scopes to the `scopes` field. Both configurations must be given as part of the service configuration.

A `401 Unauthorized` response is sent to the client when the authentication fails, and a `403 Forbidden` response is sent to the client when the authorization fails. Use this to authenticate and authorize requests based on user stores. Furthermore, the authentication and authorization configurations can be overwritten at the resource level using the `@http:ResourceConfig` annotation.

::: code http_service_basic_authentication_file_user_store.bal :::

## Prerequisites
- Populate the `Config.toml` file correctly with the user information as shown below.

::: code Config.toml :::

Run the service by executing the command below.

::: out http_service_basic_authentication_file_user_store.server.out :::

>**Tip:** You can invoke the above service via the [Basic authentication client](/learn/by-example/http-client-basic-authentication).

## Related links
- [`http:FileUserStoreConfig` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/FileUserStoreConfig)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [HTTP service listener basic authentication file user store - Specification](/spec/http/#9111-listener---basic-auth---file-user-store)
