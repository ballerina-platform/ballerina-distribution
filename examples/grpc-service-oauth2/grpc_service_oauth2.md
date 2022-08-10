# Service - OAuth2

A gRPC service/resource can be secured with OAuth2 and by enforcing
authorization optionally. Then, it validates the OAuth2 token sent in the
`Authorization` metadata against the provided configurations. This calls the
configured introspection endpoint to validate.<br/>
Ballerina uses the concept of scopes for authorization. A resource declared
in a service can be bound to one/more scope(s). The scope can be included
in the introspection response using a custom claim attribute. That custom
claim attribute also can be configured as the `scopeKey`.<br/>
In the authorization phase, the scopes of the service/resource are compared
against the scope included in the introspection response for at least one
match between the two sets.<br/><br/>
For more information on the underlying module,
see the [OAuth2 module](https://lib.ballerina.io/ballerina/oauth2/latest/).

::: code grpc_service.proto :::

::: out grpc_service.out :::

::: code grpc_service_oauth2.bal :::

::: out grpc_service_oauth2.server.out :::