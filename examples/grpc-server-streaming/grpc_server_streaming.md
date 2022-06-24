# Server streaming RPC

The gRPC Server Connector is used to expose gRPC services over HTTP/2.
In a gRPC server streaming scenario, a client sends a request to the server and gets a stream to read the messages until all the messages are read.<br/><br/>
For more information on the underlying module, 
see the [GRPC module](https://docs.central.ballerina.io/ballerina/grpc/latest/).

::: code grpc_server_streaming.proto :::

::: out grpc_server_streaming.out :::

::: code grpc_server_streaming_service.bal :::

::: out grpc_server_streaming_service.out :::

::: code grpc_server_streaming_service_client.bal :::

::: out grpc_server_streaming_service_client.out :::