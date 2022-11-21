# gRPC service - Server reflection

Server reflection is a gRPC feature that allows dynamic clients, such as command-line tools for debugging, to discover the protocol used by a gRPC server at run time.
 
>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

>**Info:** Setting up the service is the same as setting up the simple RPC service with additional configurations. You can refer to the [simple RPC service](/learn/by-example/grpc-service-simple/) to implement the service used below.

After implementing the service, you can enable server reflection by providing the `reflectionEnabled` configuration.
   
   ::: code grpc_server_reflection.bal :::

Execute the command below to run the service.

   ::: out grpc_server_reflection.out :::

After running the service, you can use a tool like [`gRPCurl`](https://github.com/fullstorydev/grpcurl), [`Postman`](https://www.postman.com/), [`evans CLI`](https://github.com/ktr0731/evans) to inspect the service.

   ::: out grpc_server_reflection_grpcurl.out :::
