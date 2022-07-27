# Service - JWT Auth

A gRPC service/resource can be secured with JWT and by enforcing
authorization optionally. Then, it validates the JWT sent in the
`Authorization` metadata against the provided configurations.

Ballerina uses the concept of scopes for authorization. A resource declared
in a service can be bound to one/more scope(s). The scope can be included
in the JWT using a custom claim attribute. That custom claim attribute
also can be configured as the `scopeKey`.

In the authorization phase, the scopes of the service/resource are compared
against the scope included in the JWT for at least one match between the two sets.

For more information on the underlying module, 
see the [`jwt` module](https://lib.ballerina.io/ballerina/jwt/latest/).

::: code grpc_service.proto :::

Create a new Protocol Buffers definition file named `grpc_service.proto` and add the service definition to it.
Run the command below in the Ballerina tools distribution for stub generation.

Once you run the command, the `grpc_service_pb.bal` file is generated inside the stubs directory.

For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

::: out grpc_service.out :::

::: code grpc_service_jwt_auth.bal :::

Create a Ballerina package.
Copy the generated `grpc_secured_pb.bal` stub file to the package.
For example, if you create a package named `service`, copy the stub file to the `service` package.

Create a new `grpc_service_jwt_auth.bal` Ballerina file inside the `service` package and add the service implementation.

Execute the commands below to build and run the 'service' package.
You may need to change the certificate file path and private key file path.

::: out grpc_service_jwt_auth.server.out :::
