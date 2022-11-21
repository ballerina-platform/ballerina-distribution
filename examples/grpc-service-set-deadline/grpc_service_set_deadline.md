# gRPC service - Set deadline

Deadlines allow gRPC clients to specify how long they are willing to wait for an RPC to complete before the RPC is terminated with the error `DEADLINE_EXCEEDED`.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

>**Info:** Setting up the service is the same as setting up the simple RPC service with additional configurations. You can refer to the [simple RPC service](/learn/by-example/grpc-service-simple/) to implement the service used below.

After implementing the service, you can add the deadline check as follows.

::: code grpc_service_set_deadline.bal :::

Execute the command below to run the service.

::: out grpc_service_set_deadline.out :::

>**Info:** You can invoke the above service via the [gRPC client - Set deadline](/learn/by-example/grpc-service-set-deadline/).
