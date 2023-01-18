# gRPC client - Set deadline

The `grpc:Client` allows setting deadlines to specify how long they are willing to wait for an RPC to complete before the RPC is terminated with an error. The deadline is set as a header using the `setDeadline` method. Use this to set an upper limit on how long a call can run.

::: code grpc_client_set_deadline.bal :::

Setting up the client is the same as setting up the simple RPC client with additional configurations. For information on implementing the client, see [gRPC client - Simple RPC](/learn/by-example/grpc-client-simple/).

## Prerequisites
- Run the gRPC service given in the [gRPC service - Check deadline](/learn/by-example/grpc-service-check-deadline/) example.

Run the client by executing the command below.

::: out grpc_client_set_deadline.out :::

## Related links
- [`grpc:setDeadline` function - API documentation](https://lib.ballerina.io/ballerina/grpc/latest/functions#setDeadline)
- [gRPC client set deadline - Specification](/spec/grpc/#61-grpc-deadline)
