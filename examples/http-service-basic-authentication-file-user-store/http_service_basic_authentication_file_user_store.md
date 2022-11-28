# HTTP service - Basic authentication file user store

An HTTP service/resource can be secured with basic authentication and optionally by enforcing authorization. Then, it validates the Basic authentication token sent in the `Authorization` header against the provided configurations. This reads data from a file, which has a TOML format. This stores the usernames, passwords for authentication, and scopes for authorization. Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). In the authorization phase, the scopes of the service/resource are compared against the scope included in the user store for at least one match between the two sets. The `Config.toml` file is used to store the usernames, passwords, and scopes. Each user can have a password and optionally assigned scopes as an array.

::: code http_service_basic_authentication_file_user_store.bal :::

>**Info:** As a prerequisite to running the service, populate the `Config.toml` file correctly with the user information as shown below.

    ```toml
    [[ballerina.auth.users]]
    username="alice"
    password="alice@123"
    scopes=["developer"]
    
    [[ballerina.auth.users]]
    username="ldclakmal"
    password="ldclakmal@123"
    scopes=["developer", "admin"]
    
    [[ballerina.auth.users]]
    username="eve"
    password="eve@123"
    ```

Run the service by executing the command below.

::: out http_service_basic_authentication_file_user_store.server.out :::

>**Info:** You can invoke the above service via the [Basic authentication client](/learn/by-example/http-client-basic-authentication).

## Related links
- [`http:FileUserStoreConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/FileUserStoreConfig)
- [`auth` package API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [`Listener basic authentication file user store` - specification](https://ballerina.io/spec/http/#9111-listener---basic-auth---file-user-store)
