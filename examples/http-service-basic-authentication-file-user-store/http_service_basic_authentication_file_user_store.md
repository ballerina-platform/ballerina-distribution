# HTTP service - Basic authentication - File user store

An HTTP service/resource can be secured with Basic authentication and optionally by enforcing authorization. Then, it validates the Basic authentication token sent in the `Authorization` header against the provided configurations. This reads data from a file, which has a TOML format. This stores the usernames, passwords for authentication, and scopes for authorization. Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). In the authorization phase, the scopes of the service/resource are compared against the scope included in the user store for at least one match between the two sets. The `Config.toml` file is used to store the usernames, passwords, and scopes. Each user can have a password and optionally assigned scopes as an array.

For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest/)  and [`http` specification](https://ballerina.io/spec/http/#9111-listener---basic-auth---file-user-store).

>**Tip:** You may need to change the certificate file path and private key file path in the code below.

::: code http_service_basic_auth_file_user_store.bal :::

>**Info:** As a prerequisite to running the service, populate the `Config.toml` file correctly with the user information as shown below.

    ```toml
    [[ballerina.auth.users]]
    username="alice"
    password="password1"
    scopes=["scope1"]
    [[ballerina.auth.users]]
    username="bob"
    password="password2"
    scopes=["scope2", "scope3"]
    ```

Run the service by executing the command below.

::: out http_service_basic_auth_file_user_store.server.out :::

>**Info:** Alternatively, you can invoke the above service via the [Basic Auth client](/learn/by-example/http-client-basic-authentication).
