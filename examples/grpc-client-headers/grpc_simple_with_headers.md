# Simple RPC client - Send/Receive headers

The gRPC module provides support for sending/receiving headers as a part of inbound/output messages. gRPC/Protobuf tool generates Context record for each protobuf message type which contains the protobuf message and header map. The header map supports string, string[] types. The string[] type returns all the values for a given header key. gRPC also provides set of Utility apis to manipulate header values.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

>**Info:** Setting up the client is the same as setting up the simple RPC client with input and output parameter change. You can refer to the [simple RPC client](/learn/by-example/grpc-client-simple/) to implement the client used below.

   ::: code grpc_simple_with_headers_service_client.bal :::

Execute the command below to run the client.

>**Info:** As a prerequisite to running the client, start the [simple RPC service with headers](learn/by-example/grpc-service-headers/).

   ::: out grpc_simple_with_headers_service_client.out :::