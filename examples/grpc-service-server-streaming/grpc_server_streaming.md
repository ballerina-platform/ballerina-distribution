# Service - Server streaming RPC

The gRPC Server Connector is used to expose gRPC services over HTTP/2. In a gRPC server streaming scenario, a client sends a request to the server and gets a stream to read the messages until all the messages are read.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

## Generate the service definition

1. Create new Protocol Buffers definition file `grpc_server_streaming.proto` and add service definition below.

    ::: code grpc_server_streaming.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

   ::: out grpc_server_streaming.out :::

Once you run the command, the `grpc_server_streaming_pb.bal` file gets generated inside the stubs directory.

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the [gRPC/Protocol Buffers](https://ballerina.io/learn/cli-documentation/grpc/) guide.

## Implement and run the service

1. Create a Ballerina package (e.g., `service`).

>**Tip:** Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_server_streaming_pb.bal` file from the `stubs` directory to the  `service` package.

3. Create a new `grpc_server_streaming.bal` file inside the `service` package and add the service implementation below.

   ::: code grpc_server_streaming_service.bal :::

4. Execute the command below to run the service.

   ::: out grpc_server_streaming_service.out :::

>**Info:** You can invoke the above service via the [server streaming RPC client](/learn/by-example/grpc-client-server-streaming/).
