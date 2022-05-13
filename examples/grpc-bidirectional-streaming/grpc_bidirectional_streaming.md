# Bidirectional streaming RPC

The gRPC Server Connector exposes the gRPC service over HTTP2.
In a gRPC bidirectional streaming scenario, the gRPC service and the client
operate when each other sends a sequence of messages using a read-write stream.
In such scenarios, the two streams operate independently. Therefore, clients and servers can read and write in any order.<br/><br/>
For more information on the underlying module, 
see the [GRPC module](https://docs.central.ballerina.io/ballerina/grpc/latest/).

::: code ./examples/grpc-bidirectional-streaming/grpc_bidirectional_streaming.proto :::

::: out ./examples/grpc-bidirectional-streaming/grpc_bidirectional_streaming.out :::

::: code ./examples/grpc-bidirectional-streaming/grpc_bidirectional_streaming_service.bal :::

::: out ./examples/grpc-bidirectional-streaming/grpc_bidirectional_streaming_service.out :::

::: code ./examples/grpc-bidirectional-streaming/grpc_bidirectional_streaming_service_client.bal :::

::: out ./examples/grpc-bidirectional-streaming/grpc_bidirectional_streaming_service_client.out :::