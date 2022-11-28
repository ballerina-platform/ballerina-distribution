# gRPC client - Server-side streaming RPC

The gRPC Server Connector is used to expose gRPC services over HTTP/2. In a gRPC server streaming scenario, a client sends a request to the server and gets a stream to read the messages until all the messages are read.

## Generate the service definition

1. Create a new Protocol Buffers definition file `grpc_server_streaming.proto` and add service definition below.

    ::: code grpc_server_streaming.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

   ::: out grpc_server_streaming.out :::

Once you run the command, the `grpc_server_streaming_pb.bal` file gets generated inside the stubs directory.

## Prerequisites
- Start the [server streaming RPC service](/learn/by-example/grpc-service-server-streaming/).

## Implement and run the client

1. Create a Ballerina package (e.g., `client`). Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_server_streaming_pb.bal` file from the `stubs` directory to the  `client` package.

3. Create a new `grpc_server_streaming_client.bal` file inside the `client` package and add the client implementation below.

   ::: code grpc_server_streaming_service_client.bal :::

4. Execute the command below to run the client.

   ::: out grpc_server_streaming_service_client.out :::

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [Server-side streaming - Specification](/spec/grpc/#42-server-streaming-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)
