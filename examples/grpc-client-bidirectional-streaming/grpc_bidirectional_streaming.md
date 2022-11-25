# gRPC client - Bidirectional streaming RPC

The gRPC server connector exposes the gRPC service over HTTP2. In a gRPC bidirectional streaming scenario, the gRPC service and the client operate when each other sends a sequence of messages using a read-write stream. In such scenarios, the two streams operate independently. Therefore, clients and servers can read and write in any order.

## Generate the service definition

1. Create a new Protocol Buffers definition file `grpc_bidirectional_streaming.proto` and add the service definition below.

   ::: code grpc_bidirectional_streaming.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

   ::: code grpc_bidirectional_streaming.out :::

Once you run the command, the `grpc_bidirectional_streaming_pb.bal` file gets generated inside the `stubs` directory.

## Prerequisites
- Start the [bidirectional streaming RPC service](learn/by-example/grpc-service-bidirectional-streaming/).

## Implement and run the client

1. Create a Ballerina package (e.g., `client`). Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_bidirectional_streaming_pb.bal` file from the `stubs` directory to the  `client` package.

3. Create a new `grpc_bidirectional_streaming_client.bal` file inside the `client` package and add the client implementation below.

    ::: code grpc_bidirectional_streaming_service_client.bal :::

4. Execute the command below to run the client.

    ::: out grpc_bidirectional_streaming_service_client.out :::

## Related links
- [Bidirectional streaming - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [Bidirectional streaming - specification](/spec/grpc/#44-bidirectional-streaming-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)