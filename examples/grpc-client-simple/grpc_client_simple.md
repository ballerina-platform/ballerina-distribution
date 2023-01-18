# gRPC client - Simple RPC

A `grpc:Client` is created by providing the endpoint URL of a gRPC server. In the simple RPC scenario, once connected, the client sends a request message to the remote service and waits for the response message. Use this to send a single request message and get a single response message back. 

## Generate the service definition

1. Create a new Protocol Buffers definition file named `grpc_simple.proto` and add the service definition below.

    ::: code grpc_client_simple.proto :::

2. Run the command below from the Ballerina tools distribution for stub generation.

   ::: out grpc_simple.out :::

Once you run the command, the `grpc_simple_pb.bal` file gets generated inside the `stubs` directory.

## Prerequisites
- Run the gRPC service given in the [gRPC service - Simple RPC](/learn/by-example/grpc-service-simple/) example.

## Implement and run the client

1. Create a Ballerina package (e.g., `client`). Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_simple_pb.bal` file from the `stubs` directory to the  `client` package.

3. Create a new `grpc_simple_client.bal` file inside the `client` package and add the client implementation below.

   ::: code grpc_client_simple.bal :::

4. Run the client by executing the command below.

   ::: out grpc_client_simple.out :::

## Related links
- [`grpc` module - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [gRPC client simple RPC - Specification](/spec/grpc/#41-simple-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)
