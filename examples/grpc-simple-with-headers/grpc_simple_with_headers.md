# Simple RPC with headers

The gRPC Server Connector exposes the gRPC service over HTTP2.
In a simple RPC call, a client sends a request to a remote service and waits for the response.
The headers can be passed using the context record that is generated for each Protobuf message.<br/><br/>
For more information on the underlying module, 
see the [GRPC module](https://docs.central.ballerina.io/ballerina/grpc/latest/).

::: code ./examples/grpc-simple-with-headers/grpc_simple_with_headers.proto :::

::: out ./examples/grpc-simple-with-headers/grpc_simple_with_headers.out :::

::: code ./examples/grpc-simple-with-headers/grpc_simple_with_headers_service.bal :::

::: out ./examples/grpc-simple-with-headers/grpc_simple_with_headers_service.out :::

::: code ./examples/grpc-simple-with-headers/grpc_simple_with_headers_service_client.bal :::

::: out ./examples/grpc-simple-with-headers/grpc_simple_with_headers_service_client.out :::