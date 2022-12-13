# gRPC client - Bidirectional streaming RPC

A `grpc:Client` is created by providing the endpoint URL of gRPC server. In the bidirectional streaming scenario, Once connected, the client and the service sends message streams to each other. In this scenario, the two streams operate independently and therefore, clients and servers can read and write in any order. Use this to send multiple requests to a server and get multiple responses back.

## Generate the service definition

1. Create a new Protocol Buffers definition file `grpc_bidirectional_streaming.proto` and add the service definition below.

   ::: code grpc_bidirectional_streaming.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

   ::: code grpc_bidirectional_streaming.out :::

Once you run the command, the `grpc_bidirectional_streaming_pb.bal` file gets generated inside the `stubs` directory.

## Prerequisites
- Run the gRPC service given in the [bidirectional streaming RPC service](/learn/by-example/grpc-service-bidirectional-streaming/) example.

## Implement and run the client

1. Create a Ballerina package (e.g., `client`). Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_bidirectional_streaming_pb.bal` file from the `stubs` directory to the  `client` package.

3. Create a new `grpc_bidirectional_streaming_client.bal` file inside the `client` package and add the client implementation below.

    ::: code grpc_bidirectional_streaming_service_client.bal :::

4. Execute the command below to run the client.

    ::: out grpc_bidirectional_streaming_service_client.out :::

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [gRPC client bidirectional streaming - Specification](/spec/grpc/#44-bidirectional-streaming-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)