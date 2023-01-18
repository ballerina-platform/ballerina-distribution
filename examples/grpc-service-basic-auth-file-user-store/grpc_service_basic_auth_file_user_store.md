# gRPC service - Basic authentication file user store

The `grpc:Service` can be secured with basic authentication and additionally, scopes can be added to enforce authorization. It validates the basic authentication token sent in the `Authorization` metadata against the provided configurations provided in the `Config.toml` file. The file stores the usernames and passwords for the authentication and the scopes for the authorization. To engage authentication, set the default values for the `fileUserStoreConfig` field and add the `Config.toml` file next to the service file. To engage authorization, set the scopes to the `scopes` field. Both configurations must be given as part of the service configuration.

A `grpc:UnauthenticatedError` is sent to the client when the authentication fails, and a `grpc:PermissionDeniedError` is sent to the client when the authorization fails. Use this to authenticate and authorize requests based on user stores.

   ::: code grpc_service_basic_auth_file_user_store.bal :::

## Prerequisites
- Populate the `Config.toml` file correctly with the user information as shown below.

    ::: code Config.toml :::

Setting up the service is the same as setting up the simple RPC service with additional configurations. For information on implementing the service, see [gRPC service - Simple RPC](/learn/by-example/grpc-service-simple/).

Run the service by executing the command below.

   ::: out grpc_service_basic_auth_file_user_store.server.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Basic authentication](/learn/by-example/grpc-client-basic-auth).

## Related links
- [`grpc:FileUserStoreConfig` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/records/FileUserStoreConfig)
- [gRPC service basic authentication file user store - Specification](/spec/grpc/#5111-service---basic-auth---file-user-store)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
