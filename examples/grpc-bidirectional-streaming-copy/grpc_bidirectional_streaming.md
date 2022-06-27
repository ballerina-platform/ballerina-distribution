# Bidirectional streaming RPC copy

The gRPC Server Connector exposes the gRPC service over HTTP2. In a gRPC bidirectional streaming scenario, the gRPC service and the client operate when each other sends a sequence of messages using a read-write stream. In such scenarios, the two streams operate independently. Therefore, clients and servers can read and write in any order.

>**Info:** For more information on the underlying module, see the [GRPC module](https://docs.central.ballerina.io/ballerina/grpc/latest/).

## Generate the service definition

1. Create a new directory (e.g., `grpc_bidirectional_streaming`).

2. Create a new Protocol Buffers definition file `grpc_bidirectional_streaming.proto` and add the service definition below to it.

    ::: code grpc_bidirectional_streaming.proto :::

3. Navigate to the `grpc_bidirectional_streaming` directory, and run the command below for stub generation.

    ```bash
    bal grpc --input grpc_bidirectional_streaming.proto  --output stubs
    ```

You view the output below.
    
::: out grpc_bidirectional_streaming.out :::

Once you run the command, the `grpc_bidirectional_streaming_pb.bal` file gets generated inside the `stubs` directory. 

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

## Execute the service

1. Create another Ballerina package (e.g., `service`) by executing the command below.

>**Tip:** Delete the `main.bal` file created by default as it is not required for this example.

```bash
bal new service
```

2. Copy the generated `grpc_bidirectional_streaming_pb.bal` file from the `stubs` directory to the  `service` package.

3. Create a new `grpc_bidirectional_streaming_service.bal` Ballerina file inside the `service` package and add the service implementation.

::: code grpc_bidirectional_streaming_service.bal :::

4. Execute the command below to build the 'service' package.

    ```bash
    bal build service
    ```

5. Run the service using the command below.

    ```bash
    bal run service/target/bin/service.jar
    ```

You view the output below.

::: out grpc_bidirectional_streaming_service.out :::

## Execute the client

1. Create another Ballerina package (e.g., `client`) by executing the command below.

>**Tip:** Delete the `main.bal` file created by default as it is not required for this example.

```bash
bal new client
```

2. Copy the generated `grpc_bidirectional_streaming_pb.bal` file from the `stubs` directory to the  `service` package.

3. Create a new `grpc_bidirectional_streaming_client.bal` Ballerina file inside the `client` package and add the client implementation.

    ::: code grpc_bidirectional_streaming_service_client.bal :::

4. Execute the command below to build the 'client' package.

    ```bash
    bal build client
    ```

5. Run the client using the command below.

```bash
bal run client/target/bin/client.jar
```

You view the output below.

::: out grpc_bidirectional_streaming_service_client.out :::