# gRPC client - Self signed JWT auth

A client, which is secured with self-signed JWT can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `http:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

>**Info:** For more information on the underlying module, see the [`oauth2` module](https://lib.ballerina.io/ballerina/oauth2/latest/).

>**Info:** Setting up the client is the same as setting up the simple RPC client with additional configurations. You can refer to the [simple RPC client](/learn/by-example/grpc-client-simple/) to implement the client used below.

>**Tip:** You may need to change the trusted certificate file path and private key file path in the code below. 

   ::: code grpc_client_self_signed_jwt_auth.bal :::

Execute the command below to run the client.

>**Info:** As a prerequisite to running the client, start the [JWT Auth service](/learn/by-example/grpc-service-jwt-auth/).

   ::: out grpc_client_self_signed_jwt_auth.out :::
