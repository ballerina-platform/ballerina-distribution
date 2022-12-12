# gRPC client - Send/Receive headers

The gRPC client allows sending headers and receiving headers from a gRPC server. gRPC - Protobuf CLI tool generates Context record for each protobuf message type which contains the protobuf message and the header map. The header map supports `string`, `string[]` types. A Context record value is created with the required headers and sent using the context method of the client (`helloContext()`). The Context type of the required record is provided as the target type of the response to receive headers. `getHeader` and `getHeaders` methods are also available to manipulate the header values.

   ::: code grpc_simple_with_headers_service_client.bal :::

Setting up the client is the same as setting up the unary RPC client with input and output parameter change. You can refer to the [gRPC client - Unary RPC](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Run the gRPC service given in the [gRPC service - Send/Receive headers](/learn/by-example/grpc-service-headers/) example.

Execute the command below to run the client.

   ::: out grpc_simple_with_headers_service_client.out :::

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [`grpc` package - Specification](/spec/grpc/)
