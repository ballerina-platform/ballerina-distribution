# gRPC client - Bearer token authentication

A client, which is secured with Bearer token authentication can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:BearerTokenConfig` for the `auth` configuration of the client.

>**Info:** For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest).

>**Info:** You can refer to the [simple RPC client](/learn/by-example/grpc-client-simple/) to implement the client used below.

>**Tip:** You may need to change the trusted certificate file path in the code below.

   ::: code grpc_client_bearer_token_auth.bal :::

Execute the command below to run the client.

>**Info:** As a prerequisite to running the client, start a secured sample service.

   ::: out grpc_client_bearer_token_auth.out :::
