# Simple RPC

The gRPC Server Connector exposes the gRPC service over HTTP2.
In a simple RPC call, a client sends a request to a remote service and waits for the response.<br/><br/>
For more information on the underlying module, 
see the [GRPC module](https://docs.central.ballerina.io/ballerina/grpc/latest/).

::: code ./examples/grpc-simple/grpc_simple.proto :::

::: out ./examples/grpc-simple/grpc_simple.out :::

::: code ./examples/grpc-simple/grpc_simple_service.bal :::

::: out ./examples/grpc-simple/grpc_simple_service.out :::

::: code ./examples/grpc-simple/grpc_simple_service_client.bal :::

::: out ./examples/grpc-simple/grpc_simple_service_client.out :::