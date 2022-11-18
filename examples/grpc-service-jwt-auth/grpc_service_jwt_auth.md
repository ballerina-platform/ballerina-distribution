# JWT auth service

A gRPC service/resource can be secured with JWT and by enforcing authorization optionally. Then, it validates the JWT sent in the `Authorization` metadata against the provided configurations.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the JWT using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`.

In the authorization phase, the scopes of the service/resource are compared against the scope included in the JWT for at least one match between the two sets.

>**Info:** For more information on the underlying module, see the [`jwt` module](https://lib.ballerina.io/ballerina/jwt/latest/).

>**Info:** Setting up the service is the same as setting up the simple RPC service with additional configurations. You can refer to the [simple RPC service](/learn/by-example/grpc-service-simple/) to implement the service used below.

>**Tip:** You may need to change the certificate file path and private key file path in the code below.

   ::: code grpc_service_jwt_auth.bal :::

Execute the command below to run the service.

   ::: out grpc_service_jwt_auth.server.out :::

>**Info:** You can invoke the above service via the [gRPC self-signed JWT Auth client](/learn/by-example/grpc-client-self-signed-jwt-auth).