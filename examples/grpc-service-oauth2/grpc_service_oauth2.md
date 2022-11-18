# OAuth2 service

A gRPC service/resource can be secured with OAuth2 and by enforcing authorization optionally. Then, it validates the OAuth2 token sent in the `Authorization` metadata against the provided configurations. This calls the configured introspection endpoint to validate.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the introspection response using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`.

In the authorization phase, the scopes of the service/resource are compared against the scope included in the introspection response for at least one match between the two sets.

>**Info:** For more information on the underlying module, see the [`oauth2` module](https://lib.ballerina.io/ballerina/oauth2/latest/).

>**Info:** Setting up the service is the same as setting up the simple RPC service with additional configurations. You can refer to the [simple RPC service](/learn/by-example/grpc-service-simple/) to implement the service used below.

>**Tip:** You may need to change the certificate file path and private key file path in the code below.

   ::: code grpc_service_oauth2.bal :::

Execute the command below to run the service.

   ::: out grpc_service_oauth2.server.out :::

>**Info:** You can invoke the above service via the clients below.
 - [gRPC OAuth2 Client Credentials grant type client](/learn/by-example/grpc-client-oauth2-client-credentials-grant-type)
 - [gRPC OAuth2 Password grant type client](/learn/by-example/grpc-client-oauth2-password-grant-type)
 - [gRPC OAuth2 Refresh Token grant type client](/learn/by-example/grpc-client-oauth2-refresh-token-grant-type)
 - [gRPC OAuth2 JWT Bearer grant type client](/learn/by-example/grpc-client-oauth2-jwt-bearer-grant-type)
 