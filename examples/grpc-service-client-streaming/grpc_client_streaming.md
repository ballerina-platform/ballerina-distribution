# gRPC service - Client-side streaming RPC

The gRPC Server Connector is used to expose gRPC services over HTTP/2. In a gRPC client streaming scenario, the client writes a sequence of messages and sends them to the server. Once the client has finished writing the messages, it waits for the server to read them and return a response.

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
- [Client-side streaming - Specification](/spec/grpc/#43-client-streaming-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)
