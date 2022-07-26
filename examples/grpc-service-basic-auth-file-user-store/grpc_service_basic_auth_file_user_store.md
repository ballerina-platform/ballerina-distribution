# Service - Basic Auth file user store

A gRPC service/resource can be secured with Basic Auth and optionally by
enforcing authorization. Then, it validates the Basic Auth token sent as the
`Authorization` metadata against the provided configurations. This reads data
from a file, which has a TOML format. This stores the usernames, passwords
for authentication, and scopes for authorization.

Ballerina uses the concept of scopes for authorization. A resource declared
in a service can be bound to one/more scope(s).

In the authorization phase, the scopes of the service/resource are compared
against the scope included in the user store for at least one match between the two sets.

`Config.toml` has defined three users - alice, ldclakmal, and eve. Each user has a
password and optionally assigned scopes as an array.

For more information on the underlying module,
see the [Auth module](https://lib.ballerina.io/ballerina/auth/latest/).

::: code grpc_service.proto :::

Create a new Protocol Buffers definition file named `grpc_service.proto` and add the service definition to it.
Run the command below in the Ballerina tools distribution for stub generation.

Once you run the command, `grpc_service_pb.bal` file is generated inside stubs directory.

For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

::: out grpc_service.out :::

::: code grpc_service_basic_auth_file_user_store.bal :::

Create a Ballerina package.
Copy the generated `grpc_secured_pb.bal` stub file to the package.
For example, if you create a package named `service`, copy the stub file to the `service` package.

Create a new `grpc_service_basic_auth_file_user_store.bal` Ballerina file inside the `service` package and add the service implementation.

As a prerequisite, ensure that the `Config.toml` file is populated correctly with the user information.

Execute the commands below to build and run the 'service' package.
You may need to change the certificate file path and private key file path.

::: out grpc_service_basic_auth_file_user_store.server.out :::
