# Service - Simple RPC

The gRPC Server Connector exposes the gRPC service over HTTP2. In a simple RPC call, a client sends a request to a remote service and waits for the response.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

## Generate the service definition

1. Create a new Protocol Buffers definition file named `grpc_simple.proto` and add the service definition below.

    ::: code grpc_simple.proto :::

2. Run the command below from the Ballerina tools distribution for stub generation.

   ::: out grpc_simple.out :::

Once you run the command, the `grpc_simple_pb.bal` file gets generated inside the `stubs` directory.

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the [gRPC/Protocol Buffers](https://ballerina.io/learn/cli-documentation/grpc/) guide.

## Implement and run the service

1. Create a Ballerina package (e.g., `service`).

>**Tip:** Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_simple_pb.bal` stub file from the `stubs` directory to the  `service` package.

3. Create a new `grpc_simple.bal` file inside the `service` package and add the service implementation below.

   ::: code grpc_simple_service.bal :::

4. Execute the commands below to run the service.

   ::: out grpc_simple_service.out :::

>**Info:** You can invoke the above service via the [simple RPC client](/learn/by-example/grpc-client-simple/).
