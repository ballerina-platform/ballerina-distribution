# Service - Send/Receive headers

The gRPC module provides support for sending/receiving headers as a part of inbound/output messages. gRPC/Protobuf tool generates Context record for each protobuf message type which contains the protobuf message and header map. The header map supports string, string[] types. The string[] type returns all the values for a given header key. gRPC also provides set of Utility apis to manipulate header values.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

>**Info:** Setting up the service is the same as setting up the simple RPC service with input and output parameter change. You can refer to the [simple RPC service](/learn/by-example/grpc-service-simple/) to implement the service used below.

   ::: code grpc_simple_with_headers_service.bal :::

Execute the command below to run the service.

   ::: out grpc_simple_with_headers_service.out :::

>**Info:** You can invoke the above service via the [simple RPC client with headers](/learn/by-example/grpc-client-headers/).
