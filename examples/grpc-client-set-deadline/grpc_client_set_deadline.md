# gRPC client - Set deadline

Deadlines allow gRPC clients to specify how long they are willing to wait for an RPC to complete before the RPC is terminated with the error `DEADLINE_EXCEEDED`.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

>**Info:** Setting up the client is the same as setting up the simple RPC client with additional configurations. You can refer to the [simple RPC client](/learn/by-example/grpc-client-simple/) to implement the client used below.

You can set the deadline as a header as follows.

::: code grpc_client_set_deadline.bal :::

Execute the command below to run the client. Output will depend on how the service has been implemented.

>**Info:** As a prerequisite to running the client, start a [sample service with/without a configured deadline](/learn/by-example/grpc-service-set-deadline/).

::: out grpc_client_set_deadline.out :::
