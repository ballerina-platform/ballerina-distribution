# gRPC service - Client-side streaming RPC

A `grpc:Listener` is created by providing the port and a `grpc:Service` is attached to it. In the client streaming scenario, once a client is connected to the service, the client sends a message stream to the server. Once the client completes the request, the server sends the response to complete the call. Use this to receive multiple requests from a client and send a single response back.

## Generate the service definition

1. Create new Protocol Buffers definition file `grpc_client_streaming.proto` and add service definition below.

   ::: code grpc_client_streaming.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

   ::: out grpc_client_streaming.out :::

Once you run the command, the `grpc_client_streaming_pb.bal` file gets generated inside the stubs directory.

## Implement and run the service

1. Create a Ballerina package (e.g., `service`).
   
2. Copy the generated `grpc_client_streaming_pb.bal` file from the `stubs` directory to the  `service` package.

3. Create a new `grpc_client_streaming.bal` file inside the `service` package and add the service implementation below.

   ::: code grpc_client_streaming_service.bal :::
   
4. Execute the command below to run the service.

   ::: out grpc_client_streaming_service.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Client-side streaming RPC](/learn/by-example/grpc-client-client-streaming/).

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [gRPC service client-side streaming - Specification](/spec/grpc/#43-client-streaming-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)
