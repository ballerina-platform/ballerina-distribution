# gRPC service - Bidirectional streaming RPC

The gRPC server connector exposes the gRPC service over HTTP2. In a gRPC bidirectional streaming scenario, the gRPC service and the client operate when each other sends a sequence of messages using a read-write stream. In such scenarios, the two streams operate independently. Therefore, clients and servers can read and write in any order.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

## Generate the service definition

1. Create a new Protocol Buffers definition file `grpc_bidirectional_streaming.proto` and add the service definition below.

    ::: code grpc_bidirectional_streaming.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

    ::: code grpc_bidirectional_streaming.out :::

Once you run the command, the `grpc_bidirectional_streaming_pb.bal` file gets generated inside the `stubs` directory. 

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the [gRPC/Protocol Buffers](https://ballerina.io/learn/cli-documentation/grpc/) guide.

## Implement and run the service

1. Create a Ballerina package (e.g., `service`).

>**Tip:** Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_bidirectional_streaming_pb.bal` file from the `stubs` directory to the  `service` package.

3. Create a new `grpc_bidirectional_streaming_service.bal` file inside the `service` package and add the service implementation below.

    ::: code grpc_bidirectional_streaming_service.bal :::

4. Execute the command below to run the service.

    ::: out grpc_bidirectional_streaming_service.out :::

>**Info:** You can invoke the above service via the [bidirectional streaming RPC client](/learn/by-example/grpc-client-bidirectional-streaming/).
