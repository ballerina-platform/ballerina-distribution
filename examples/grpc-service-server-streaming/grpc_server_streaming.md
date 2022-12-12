# gRPC service - Server-side streaming RPC

The gRPC server communicates with a gRPC client over HTTP2. A `grpc:Listener` is created by providing the port, and a `grpc:Service` is attached to it. In the server streaming scenario, once a client is connected to the service and sends a request, the service sends multiple messages to the client. Use this to receive a single request from a client and send multiple responses back.

## Generate the service definition

1. Create new Protocol Buffers definition file `grpc_server_streaming.proto` and add service definition below.

    ::: code grpc_server_streaming.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

   ::: out grpc_server_streaming.out :::

Once you run the command, the `grpc_server_streaming_pb.bal` file gets generated inside the stubs directory.

## Implement and run the service

1. Create a Ballerina package (e.g., `service`). Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_server_streaming_pb.bal` file from the `stubs` directory to the  `service` package.

3. Create a new `grpc_server_streaming.bal` file inside the `service` package and add the service implementation below.

   ::: code grpc_server_streaming_service.bal :::

4. Execute the command below to run the service.

   ::: out grpc_server_streaming_service.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Server-side streaming RPC](/learn/by-example/grpc-client-server-streaming/).

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [gRPC service server-side streaming - Specification](/spec/grpc/#42-server-streaming-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)
