# gRPC service - Basic authentication file user store

A gRPC service/resource can be secured with Basic authentication and optionally by enforcing authorization. Then, it validates the Basic Auth token sent as the `Authorization` metadata against the provided configurations. This reads data from a file, which has a TOML format. This stores the usernames, passwords for authentication, and scopes for authorization.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s).

In the authorization phase, the scopes of the service/resource are compared against the scope included in the user store for at least one match between the two sets.

The `Config.toml` file is used to store the usernames, passwords, and scopes. Each user can have a password and optionally assigned scopes as an array.

   ::: code grpc_service_basic_auth_file_user_store.bal :::

As a prerequisite, execute the command below to populate the `Config.toml` file correctly with the user information.

    ```bash
    $ echo '[[ballerina.auth.users]]
    username="alice"
    password="password1"
    scopes=["scope1"]
    [[ballerina.auth.users]]
    username="bob"
    password="password2"
    scopes=["scope2", "scope3"]' > Config.toml
    ```

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

Execute the command below to run the service.

   ::: out grpc_service_basic_auth_file_user_store.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Basic authentication](/learn/by-example/grpc-client-basic-auth).

## Related links
- [`grpc:FileUserStoreConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/FileUserStoreConfig)
- [Basic authentication file user store - Specification](/spec/grpc/#5111-service---basic-auth---file-user-store)
- [`auth` package - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
