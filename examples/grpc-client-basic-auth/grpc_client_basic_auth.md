# Client - Basic Auth

A client, which is secured with Basic Auth can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Basic <token>`
header by passing the `grpc:CredentialsConfig` for the `auth` configuration of the client.

For more information on the underlying module, see the [Auth module](https://lib.ballerina.io/ballerina/auth/latest).

::: code grpc_client.proto :::

Create a new Protocol Buffers definition file named `grpc_client.proto` and add the service definition to it.
Run the command below in the Ballerina tools distribution for stub generation.

Once you run the command, `grpc_client_pb.bal` file is generated inside stubs directory.

For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

::: out grpc_client.out :::

::: code grpc_client_basic_auth.bal :::

Create a Ballerina package.
Copy the generated `grpc_secured_pb.bal` stub file to the package.
For example, if you create a package named `client`, copy the stub file to the `client` package.

Create a new `grpc_client_basic_auth.bal` Ballerina file inside the `client` package and add the client implementation.

Execute the commands below to build and run the 'client' package.
You may need to change the trusted certificate file path.

As a prerequisite, start a sample service secured with Basic Auth.

::: out grpc_client_basic_auth.out :::
