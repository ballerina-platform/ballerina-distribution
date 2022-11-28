# gRPC client - Send/Receive headers

The gRPC module provides support for sending/receiving headers as a part of inbound/output messages. gRPC/Protobuf tool generates Context record for each protobuf message type which contains the protobuf message and header map. The header map supports string, string[] types. The string[] type returns all the values for a given header key. gRPC also provides set of Utility apis to manipulate header values.

   ::: code grpc_simple_with_headers_service_client.bal :::

Setting up the client is the same as setting up the unary RPC client with input and output parameter change. You can refer to the [unary RPC client](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Start the [simple RPC service with headers](/learn/by-example/grpc-service-headers/).

Execute the command below to run the client.

   ::: out grpc_simple_with_headers_service_client.out :::

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [`grpc` package - Specification](/spec/grpc/)
