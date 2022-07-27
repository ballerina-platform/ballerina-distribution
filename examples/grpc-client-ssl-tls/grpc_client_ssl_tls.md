# Client - SSL/TLS

You can use the gRPC client to connect or interact with a gRPC listener secured with SSL/TLS.
Provide the `grpc:ClientSecureSocket` configurations to the client to
initiate an HTTPS connection over HTTP/2.

For more information on the underlying module,
see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

::: code grpc_client.proto :::

Create a new Protocol Buffers definition file named `grpc_client.proto` and add the service definition to it.
Run the command below in the Ballerina tools distribution for stub generation.

Once you run the command, the `grpc_client_pb.bal` file is generated inside the stubs directory.

For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

::: out grpc_client.out :::

::: code grpc_client_ssl_tls.bal :::

Create a Ballerina package.
Copy the generated `grpc_secured_pb.bal` stub file to the package.
For example, if you create a package named `client`, copy the stub file to the `client` package.

Create a new `grpc_client_ssl_tls.bal` Ballerina file inside the `client` package and add the client implementation.

Execute the commands below to build and run the 'client' package.
You may need to change the trusted certificate file path.

As a prerequisite, start a sample service secured with SSL.

::: out grpc_client_ssl_tls.out :::
