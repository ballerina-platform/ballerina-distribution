# Client streaming RPC

The gRPC Server Connector is used to expose gRPC services over HTTP/2.
In a gRPC client streaming scenario, the client writes a sequence of messages and sends them to the server.
Once the client has finished writing the messages, it waits for the server to read them and return a response.

For more information on the underlying module, 
see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

::: code grpc_client_streaming.proto :::

Create new Protocol Buffers definition file `grpc_client_streaming.proto` and add service definition.
Run the command below in the Ballerina tools distribution for stub generation.

Once you run the command, the `grpc_client_streaming_pb.bal` file is generated inside the stubs directory.

For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

::: out grpc_client_streaming.out :::

::: code grpc_client_streaming_service.bal :::

Create a Ballerina package.
Copy the generated `grpc_client_streaming_pb.bal` stub file to the package.
For example, if you create a package named `service`, copy the stub file to the `service` package.

Create a new `grpc_client_streaming.bal` Ballerina file inside the `service` package and add the service implementation.

Execute the commands below to build and run the 'service' package.

::: out grpc_client_streaming_service.out :::

::: code grpc_client_streaming_service_client.bal :::

Create a Ballerina package.
Copy the generated `grpc_client_streaming_pb.bal` stub file to the package.
For example, if you create a package named `client`, copy the stub file to the `client` package.

Create a new `grpc_client_streaming_client.bal` Ballerina file inside the `client` package and add the client implementation.

Execute the commands below to build and run the 'client' package.

::: out grpc_client_streaming_service_client.out :::
