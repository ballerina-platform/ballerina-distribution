# gRPC service - Server reflection

The `grpc:Listener` provides the server reflection capability, which allows dynamic clients such as command-line tools for debugging to discover the protocol used by a gRPC server at run time. Server reflection is enabled by providing the `reflectionEnabled` configuration in the `grpc:ListenerConfiguration`.

   ::: code grpc_server_reflection.bal :::

Setting up the service is the same as setting up the simple RPC service with additional configurations. For information on implementing the service, see [gRPC service - Simple RPC](/learn/by-example/grpc-service-simple/).

Run the service by executing the command below.

   ::: out grpc_server_reflection.out :::

After running the service, you can use a tool like [`gRPCurl`](https://github.com/fullstorydev/grpcurl), [`Postman`](https://www.postman.com/), [`evans CLI`](https://github.com/ktr0731/evans) to inspect the service.

   ::: out grpc_server_reflection_grpcurl.out :::

## Related links
- [`grpc:ListenerConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/grpc/latest#ListenerConfiguration)
- [gRPC service server reflection - Specification](/spec/grpc/#7-grpc-server-reflection)
