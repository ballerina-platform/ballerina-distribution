# gRPC service - Check deadline

The `grpc:Service` allows to check whether a deadline has been exceeded in a client connection. Deadlines allow gRPC clients to specify how long they are willing to wait for an RPC to complete. The deadline is checked in the service using the method `isCancelled` and a `grpc:DeadlineExceededError` is returned if it is exceeded. Use this to check the upper limit on how long a call can run for.

::: code grpc_service_check_deadline.bal :::

Setting up the service is the same as setting up the unary RPC service with additional configurations. You can refer to the [gRPC service - Unary RPC](/learn/by-example/grpc-service-unary/) to implement the service used below.

Execute the command below to run the service.

::: out grpc_service_check_deadline.out :::

>**Tip:** You can invoke the above service via the [gRPC client - Set deadline](/learn/by-example/grpc-client-set-deadline/).

## Related links
- [`grpc:isCancelled` function - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/functions#isCancelled)
- [gRPC service check deadline - Specification](/spec/grpc/#61-grpc-deadline)
