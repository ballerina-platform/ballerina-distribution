# gRPC service - Send/Receive headers

The `grpc:Service` allows receiving headers and sending headers from/to a gRPC server. The gRPC - Protobuf CLI tool generates a `Context` record for each Protobuf message type, which contains the Protobuf message and the header map. The header map supports `string`and `string[]` types. The `Context` type of the required record is provided as the target type of the remote function to receive the headers. A `Context` record value is created with the required headers and is returned to the client. The `getHeader` and `getHeaders` methods are also available to manipulate the header values.

   ::: code grpc_simple_with_headers_service.bal :::

Setting up the service is the same as setting up the unary RPC service with input and output parameter change. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

Execute the command below to run the service.

   ::: out grpc_simple_with_headers_service.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Send/Receive headers](/learn/by-example/grpc-client-headers/).

## Related links
- [`grpc` package - API documentation](https://lib.ballerina.io/ballerina/grpc/latest)
- [`grpc` package - Specification](/spec/grpc/)
