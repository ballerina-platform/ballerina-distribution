# gRPC service - Bidirectional streaming RPC

A `grpc:Listener` is created by providing the port, and a `grpc:Service` is attached to it. In the bidirectional streaming scenario, once a client is connected to the service, the client and the service sends message streams to each other. In this scenario, the two streams operate independently and therefore, clients and servers can read and write in any order. Use this to receive multiple request messages from a client and send multiple response messages back.

## Generate the service definition

1. Create a new Protocol Buffers definition file `grpc_bidirectional_streaming.proto` and add the service definition below.

    ::: code grpc_bidirectional_streaming.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

    ::: code grpc_bidirectional_streaming.out :::

Once you run the command, the `grpc_bidirectional_streaming_pb.bal` file gets generated inside the `stubs` directory. 

## Implement and run the service

1. Create a Ballerina package (e.g., `service`). Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_bidirectional_streaming_pb.bal` file from the `stubs` directory to the  `service` package.

3. Create a new `grpc_bidirectional_streaming_service.bal` file inside the `service` package and add the service implementation below.

    ::: code grpc_bidirectional_streaming_service.bal :::

4. Execute the command below to run the service.

    ::: out grpc_bidirectional_streaming_service.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Bidirectional streaming RPC](/learn/by-example/grpc-client-bidirectional-streaming/).

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [gRPC service bidirectional streaming - Specification](/spec/grpc/#44-bidirectional-streaming-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)
