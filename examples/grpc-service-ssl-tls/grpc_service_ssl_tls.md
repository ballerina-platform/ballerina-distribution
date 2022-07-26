# Service - SSL/TLS

You can use the gRPC listener to connect to or interact with a gRPC client secured with SSL/TLS.
Provide the `grpc:ListenerSecureSocket` configurations to the server to
expose an HTTPS connection over HTTP/2.

For more information on the underlying module, 
see the [gRPC module](https://lib.ballerina.io/ballerina/grpc/latest/).

::: code grpc_service.proto :::

Create a new Protocol Buffers definition file named `grpc_service.proto` and add the service definition to it.
Run the command below in the Ballerina tools distribution for stub generation.

Once you run the command, `grpc_service_pb.bal` file is generated inside stubs directory.

For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

::: out grpc_service.out :::

::: code grpc_service_ssl_tls.bal :::

Create a Ballerina package.
Copy the generated `grpc_secured_pb.bal` stub file to the package.
For example, if you create a package named `service`, copy the stub file to the `service` package.

Create a new `grpc_service_ssl_tls.bal` Ballerina file inside the `service` package and add the service implementation.

Execute the commands below to build and run the 'service' package.
You may need to change the certificate file path and private key file path.

::: out grpc_service_ssl_tls.server.out :::
