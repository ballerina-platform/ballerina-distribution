# Client - self signed JWT Auth

A client, which is secured with self-signed JWT can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `http:JwtIssuerConfig` to the `auth` configuration of the client. A self-signed JWT is issued before the request is sent.

For more information on the underlying module, see the [OAuth2 module](https://lib.ballerina.io/ballerina/oauth2/latest/).

4. Execute the commands below to build and run the 'client' package.

   ::: out grpc_client_self_signed_jwt_auth.out :::

You may need to change the trusted certificate file path and private key file path.

As a prerequisite, start a sample service secured with OAuth2.
