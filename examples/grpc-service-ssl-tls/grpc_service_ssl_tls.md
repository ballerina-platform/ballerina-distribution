# Service - SSL/TLS

You can use the gRPC listener to connect to or interact with a gRPC client
secured with SSL/TLS.
Provide the `grpc:ListenerSecureSocket` configurations to the server to
expose an HTTPS connection over HTTP/2.<br/><br/>
For more information on the underlying module, 
see the [gRPC module](https://docs.central.ballerina.io/ballerina/grpc/latest/).

::: code ./examples/grpc-service-ssl-tls/grpc_service.proto :::

::: out ./examples/grpc-service-ssl-tls/grpc_service.out :::

::: code ./examples/grpc-service-ssl-tls/grpc_service_ssl_tls.bal :::

::: out ./examples/grpc-service-ssl-tls/grpc_service_ssl_tls.server.out :::