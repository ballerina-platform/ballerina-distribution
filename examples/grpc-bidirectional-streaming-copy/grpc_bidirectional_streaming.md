# Bidirectional streaming RPC

The gRPC Server Connector exposes the gRPC service over HTTP2. In a gRPC bidirectional streaming scenario, the gRPC service and the client operate when each other sends a sequence of messages using a read-write stream. In such scenarios, the two streams operate independently. Therefore, clients and servers can read and write in any order.

>**Info:** For more information on the underlying module, see the [GRPC module](https://docs.central.ballerina.io/ballerina/grpc/latest/).

## Create the service definition

1. Create new Protocol Buffers definition file `grpc_bidirectional_streaming.proto` and add service definition.

    ::: code grpc_bidirectional_streaming.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

    ```bash
    bal grpc --input grpc_bidirectional_streaming.proto  --output stubs
    ```

You view the output below.
    
::: out grpc_bidirectional_streaming.out :::

Once you run the command, `grpc_bidirectional_streaming_pb.bal` file is generated inside stubs directory. 

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

## Create the service

1. Create another Ballerina package and copy the generated `grpc_bidirectional_streaming_pb.bal` stub file to the package.

(For example, if you create a package named `service`, copy the stub file to the `service` package.)

2. Create a new `grpc_bidirectional_streaming_service.bal` Ballerina file inside the `service` package and add the service implementation.

::: code grpc_bidirectional_streaming_service.bal :::

3. Execute the command below to build the 'service' package.

    ```bash
    bal build service
    ```

4. Run the service using the command below.

    ```bash
    bal run service/target/bin/service.jar
    ```

You view the output below.

::: out grpc_bidirectional_streaming_service.out :::

## Create the client

1. Create another Ballerina package and copy the generated `grpc_bidirectional_streaming_pb.bal` stub file to the package.

For example, if you create a package named `client`, copy the stub file to the `client` package.

2. Create a new `grpc_bidirectional_streaming_client.bal` Ballerina file inside the `client` package and add the client implementation.

    ::: code grpc_bidirectional_streaming_service_client.bal :::

3. Execute the command below to build the 'client' package.

    ```bash
    bal build client
    ```

4. Run the client using the command below.

```bash
bal run client/target/bin/client.jar
```

You view the output belw.

::: out grpc_bidirectional_streaming_service_client.out :::