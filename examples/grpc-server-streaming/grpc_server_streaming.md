# Server streaming RPC

The gRPC Server Connector is used to expose gRPC services over HTTP/2.
In a gRPC server streaming scenario, a client sends a request to the server and gets a stream to read the messages until all the messages are read.

For more information on the underlying module, 
see the [GRPC module](https://lib.ballerina.io/ballerina/grpc/latest/).

::: code grpc_server_streaming.proto :::

Create new Protocol Buffers definition file `grpc_server_streaming.proto` and add service definition.
Run the command below in the Ballerina tools distribution for stub generation.

Once you run the command, `grpc_server_streaming_pb.bal` file is generated inside stubs directory.

For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

::: out grpc_server_streaming.out :::

::: code grpc_server_streaming_service.bal :::

Create a Ballerina package.
Copy the generated `grpc_server_streaming_pb.bal` stub file to the package.
For example, if you create a package named `service`, copy the stub file to the `service` package.

Create a new `grpc_server_streaming.bal` Ballerina file inside the `service` package and add the service implementation.

Execute the commands below to build and run the 'service' package.

::: out grpc_server_streaming_service.out :::

::: code grpc_server_streaming_service_client.bal :::

Create a Ballerina package.
Copy the generated `grpc_server_streaming_pb.bal` stub file to the package.
For example, if you create a package named `client`, copy the stub file to the `client` package.

Create a new `grpc_server_streaming_client.bal` Ballerina file inside the `client` package and add the client implementation.

Execute the commands below to build and run the 'client' package.

::: out grpc_server_streaming_service_client.out :::
