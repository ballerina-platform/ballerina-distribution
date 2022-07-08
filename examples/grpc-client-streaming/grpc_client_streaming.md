# Client streaming RPC

The gRPC Server Connector is used to expose gRPC services over HTTP/2.
In a gRPC client streaming scenario, the client writes a sequence of messages and sends them to the server.
Once the client has finished writing the messages, it waits for the server to read them and return a response.<br/><br/>
For more information on the underlying module, 
see the [GRPC module](https://docs.central.ballerina.io/ballerina/grpc/latest/).

::: code grpc_client_streaming.proto :::

::: out grpc_client_streaming.out :::

::: code grpc_client_streaming_service.bal :::

::: out grpc_client_streaming_service.out :::

::: code grpc_client_streaming_service_client.bal :::

::: out grpc_client_streaming_service_client.out :::