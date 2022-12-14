# gRPC client - Set deadline

Deadlines allow gRPC clients to specify how long they are willing to wait for an RPC to complete before the RPC is terminated with the error `DEADLINE_EXCEEDED`.

You can set the deadline as a header as follows.

::: code grpc_client_set_deadline.bal :::

Setting up the client is the same as setting up the unary RPC client with additional configurations. You can refer to the [gRPC client - Unary RPC](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Run the gRPC service given in the [gRPC service - Check deadline](/learn/by-example/grpc-service-check-deadline/) example.

Run the client by executing the command below.

::: out grpc_client_set_deadline.out :::

## Related links
- [`grpc:setDeadline` function - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/functions#setDeadline)
- [gRPC client set deadline - Specification](/spec/grpc/#61-grpc-deadline)
