# gRPC service - Unary RPC

A `grpc:Listener` is created by providing the port and a `grpc:Service` is attached to it. In the unary scenario, once a client is connected to the service and sends a request, the service sends a single message to the client. Use this to receive a single request from a client and send a single response back.

## Generate the service definition

1. Create a new Protocol Buffers definition file named `grpc_unary.proto` and add the service definition below.

    ::: code grpc_service_unary.proto :::

2. Run the command below from the Ballerina tools distribution for stub generation.

   ::: out grpc_simple.out :::

Once you run the command, the `grpc_unary_pb.bal` file gets generated inside the `stubs` directory.

## Implement and run the service

1. Create a Ballerina package (e.g., `service`). Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_unary_pb.bal` stub file from the `stubs` directory to the  `service` package.

3. Create a new `grpc_unary_service.bal` file inside the `service` package and add the service implementation below.

   ::: code grpc_service_unary.bal :::

4. Execute the commands below to run the service.

   ::: out grpc_service_unary.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Unary RPC](/learn/by-example/grpc-client-unary/).

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [gRPC service unary RPC - Specification](/spec/grpc/#41-simple-rpc)
- [Ballerina protocol buffers guide](/learn/cli-documentation/grpc/)
