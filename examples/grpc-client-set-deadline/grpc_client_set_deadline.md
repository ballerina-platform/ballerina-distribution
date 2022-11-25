# gRPC client - Set deadline

Deadlines allow gRPC clients to specify how long they are willing to wait for an RPC to complete before the RPC is terminated with the error `DEADLINE_EXCEEDED`.

You can set the deadline as a header as follows.

::: code grpc_client_set_deadline.bal :::

Setting up the client is the same as setting up the unary RPC client with additional configurations. You can refer to the [unary RPC client](/learn/by-example/grpc-client-unary/) to implement the client used here.

## Prerequisites
- Start a [sample service with/without a configured deadline](/learn/by-example/grpc-service-set-deadline/).

Execute the command below to run the client. Output will depend on how the service has been implemented.

::: out grpc_client_set_deadline.out :::

## Related links
- [Set deadline - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/functions#setDeadline)
- [Set deadline - specification](/spec/grpc/#61-grpc-deadline)
