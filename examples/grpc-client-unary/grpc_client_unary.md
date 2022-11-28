# gRPC client - Unary RPC

The gRPC Server Connector exposes the gRPC service over HTTP2. In a unary RPC call, a client sends a request to a remote service and waits for the response.

## Generate the service definition

1. Create a new Protocol Buffers definition file named `grpc_unary.proto` and add the service definition below.

    ::: code grpc_client_unary.proto :::

2. Run the command below from the Ballerina tools distribution for stub generation.

   ::: out grpc_simple.out :::

Once you run the command, the `grpc_unary_pb.bal` file gets generated inside the `stubs` directory.

## Prerequisites
- Run the gRPC service given in the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) example.

## Implement and run the client

1. Create a Ballerina package (e.g., `client`). Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_unary_pb.bal` file from the `stubs` directory to the  `client` package.

3. Create a new `grpc_unary_client.bal` file inside the `client` package and add the client implementation below.

   ::: code grpc_client_unary.bal :::

4. Execute the command below to run the client.

   ::: out grpc_client_unary.out :::

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [Unary RPC - Specification](/spec/grpc/#41-simple-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)
