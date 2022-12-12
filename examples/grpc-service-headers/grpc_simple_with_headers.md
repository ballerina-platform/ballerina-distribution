# gRPC service - Send/Receive headers

The gRPC service allows receiving headers and sending headers to a gRPC server. gRPC - Protobuf CLI tool generates Context record for each protobuf message type which contains the protobuf message, and the header map. The header map supports `string`, `string[]` types. The Context type of the required record is provided as the target type of the remote function to receive headers. A Context record value is created with the required headers and returned to the client. `getHeader` and `getHeaders` methods are also available to manipulate the header values.

   ::: code grpc_simple_with_headers_service.bal :::

Setting up the service is the same as setting up the unary RPC service with input and output parameter change. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

Execute the command below to run the service.

   ::: out grpc_simple_with_headers_service.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Send/Receive headers](/learn/by-example/grpc-client-headers/).

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [`grpc` package - Specification](/spec/grpc/)
