# gRPC service - Check deadline

Deadlines allow gRPC clients to specify how long they are willing to wait for an RPC to complete before the RPC is terminated with the error `DEADLINE_EXCEEDED`. The service checks whether the deadline has been exceeded and will respond accordingly.

After implementing the service, you can add the deadline check as follows.

::: code grpc_service_check_deadline.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

Execute the command below to run the service.

::: out grpc_service_check_deadline.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Set deadline](/learn/by-example/grpc-client-set-deadline/).

## Related links
- [`grpc:isCancelled` function - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/functions#isCancelled)
- [gRPC service check deadline - Specification](/spec/grpc/#61-grpc-deadline)
