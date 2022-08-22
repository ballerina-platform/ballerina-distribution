# Simple RPC

The gRPC Server Connector exposes the gRPC service over HTTP2.
In a simple RPC call, a client sends a request to a remote service and waits for the response.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

## Generate the service definition

1. Create a new Protocol Buffers definition file named `grpc_simple.proto` and add the service definition.

    ::: code grpc_simple.proto :::

2. Run the command below from the Ballerina tools distribution for stub generation.

   ::: out grpc_simple.out :::

Once you run the command, the `grpc_simple_pb.bal` file is generated inside the `stubs` directory.

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the [Proto To Ballerina](https://ballerina.io/learn/by-example/proto-to-ballerina.html) example.

## Implement and run the service

1. Create a Ballerina package.

2. Copy the generated `grpc_simple_pb.bal` stub file to the package. For example, if you create a package named `service`, copy the stub file to the `service` package.

3. Create a new `grpc_simple.bal` Ballerina file inside the `service` package and add the service implementation.

   ::: code grpc_simple_service.bal :::

4. Execute the commands below to build and run the 'service' package.

   ::: out grpc_simple_service.out :::

## Implement and run the client

1. Create a Ballerina package.

2. Copy the generated `grpc_unary_blocking_pb.bal` stub file to the package. For example, if you create a package named `client`, copy the stub file to the `client` package.

3. Create a new `grpc_unary_blocking_client.bal` Ballerina file inside the `client` package and add the client implementation.

   ::: code grpc_simple_service_client.bal :::

4. Execute the commands below to build and run the 'client' package.

   ::: out grpc_simple_service_client.out :::
