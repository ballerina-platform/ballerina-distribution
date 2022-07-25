# Client - SSL/TLS

You can use the gRPC client to connect or interact with a gRPC listener
secured with SSL/TLS.
Provide the `grpc:ClientSecureSocket` configurations to the client to
initiate an HTTPS connection over HTTP/2.<br/><br/>
For more information on the underlying module,
see the [gRPC module](https://docs.central.ballerina.io/ballerina/grpc/latest/).

::: code grpc_client.proto :::

::: out grpc_client.out :::

::: code grpc_client_ssl_tls.bal :::

::: out grpc_client_ssl_tls.out :::