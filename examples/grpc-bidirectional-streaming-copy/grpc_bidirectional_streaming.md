# Bidirectional streaming RPC copy

The gRPC server connector exposes the gRPC service over HTTP2. In a gRPC bidirectional streaming scenario, the gRPC service and the client operate when each other sends a sequence of messages using a read-write stream. In such scenarios, the two streams operate independently. Therefore, clients and servers can read and write in any order.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

## Generate the service definition

1. Create a new directory (e.g., `grpc_bidirectional_streaming`).

2. Create a new Protocol Buffers definition file `grpc_bidirectional_streaming.proto` inside the `grpc_bidirectional_streaming` directory, and add the service definition below to it.

    ::: code grpc_bidirectional_streaming.proto :::

3. Navigate to the `grpc_bidirectional_streaming` directory, and run the command below for stub generation.

    ::: code grpc_bidirectional_streaming.out :::

Once you run the command, the `grpc_bidirectional_streaming_pb.bal` file gets generated inside the `stubs` directory. 

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto to Ballerina</a> example.

## Implement and run the service

1. Create another Ballerina package (e.g., `grpc_chat_service`) by executing the command below.

>**Tip:** Delete the `main.bal` file created by default as it is not required for this example.

```bash
bal new grpc_chat_service
```

2. Copy the generated `grpc_bidirectional_streaming_pb.bal` file from the `stubs` directory to the  `grpc_chat_service` package.

3. Create a new `grpc_bidirectional_streaming_service.bal` Ballerina file inside the `grpc_chat_service` package and add the service implementation below.

::: code grpc_bidirectional_streaming_service.bal :::

4. Execute the command below to run the service.

::: out grpc_bidirectional_streaming_service.out :::

## Execute the client

1. Create another Ballerina package (e.g., `grpc_chat_client`) by executing the command below.

>**Tip:** Delete the `main.bal` file created by default as it is not required for this example.

```bash
bal new grpc_chat_client
```

2. Copy the generated `grpc_bidirectional_streaming_pb.bal` file from the `stubs` directory to the  `grpc_chat_client` package.

3. Create a new `grpc_bidirectional_streaming_client.bal` Ballerina file inside the `grpc_chat_client` package and add the client implementation below.

    ::: code grpc_bidirectional_streaming_service_client.bal :::

4. Execute the command below to run the client.

    ::: out grpc_bidirectional_streaming_client.out :::
      