# Client - Basic Auth

A client, which is secured with Basic Auth can be used to connect to
a secured service.<br/>
The client metadata is enriched with the `Authorization: Basic <token>`
header by passing the `grpc:CredentialsConfig` for the `auth` configuration
of the client.<br/><br/>
For more information on the underlying module,
see the [Auth module](https://docs.central.ballerina.io/ballerina/auth/latest/).

::: code ./examples/grpc-client-basic-auth/grpc_client.proto :::

::: out ./examples/grpc-client-basic-auth/grpc_client.out :::

::: code ./examples/grpc-client-basic-auth/grpc_client_basic_auth.bal :::

::: out ./examples/grpc-client-basic-auth/grpc_client_basic_auth.out :::