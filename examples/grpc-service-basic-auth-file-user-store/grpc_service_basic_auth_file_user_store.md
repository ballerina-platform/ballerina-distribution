# Basic auth service - File user store

A gRPC service/resource can be secured with Basic Auth and optionally by enforcing authorization. Then, it validates the Basic Auth token sent as the `Authorization` metadata against the provided configurations. This reads data from a file, which has a TOML format. This stores the usernames, passwords for authentication, and scopes for authorization.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s).

In the authorization phase, the scopes of the service/resource are compared against the scope included in the user store for at least one match between the two sets.

The `Config.toml` file is used to store the usernames, passwords, and scopes. Each user can have a password and optionally assigned scopes as an array.

>**Info:** For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest/).

>**Info:** Setting up the service is the same as setting up the simple RPC service with additional configurations. You can refer to the [simple RPC service](/learn/by-example/grpc-service-simple/) to implement the service used below.

>**Tip:** You may need to change the certificate file path and private key file path in the code below.  

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

Execute the command below to run the service.

   ::: out grpc_service_basic_auth_file_user_store.server.out :::

>**Info:** You can invoke the above service via the [gRPC Basic Auth client](/learn/by-example/grpc-client-basic-auth).