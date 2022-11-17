# Simple RPC

The gRPC Server Connector exposes the gRPC service over HTTP2. In a simple RPC call, a client sends a request to a remote service and waits for the response.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

## Generate the service definition

1. Create a new Protocol Buffers definition file named `grpc_simple.proto` and add the service definition below.

    ::: code grpc_simple.proto :::

2. Run the command below from the Ballerina tools distribution for stub generation.

   ::: out grpc_simple.out :::

Once you run the command, the `grpc_simple_pb.bal` file gets generated inside the `stubs` directory.

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the [gRPC/Protocol Buffers](https://ballerina.io/learn/cli-documentation/grpc/) guide.

## Implement and run the client

1. Create a Ballerina package (e.g., `client`).

>**Tip:** Delete the `main.bal` file created by default as it is not required for this example.

2. Copy the generated `grpc_unary_blocking_pb.bal` file from the `stubs` directory to the  `client` package.

3. Create a new `grpc_unary_blocking_client.bal` file inside the `client` package and add the client implementation below.

   ::: code grpc_simple_service_client.bal :::

4. Execute the command below to run the client.

>**Info:** As a prerequisite to running the client, start the [simple RPC service](earn/by-example/grpc-service-simple/).

   ::: out grpc_simple_service_client.out :::
