# Service - OAuth2

An HTTP service/resource can be secured with OAuth2 and by enforcing authorization optionally. Then, it validates the OAuth2 token sent in the `Authorization` header against the provided configurations. This calls the configured introspection endpoint to validate.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the introspection response using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`.

In the authorization phase, the scopes of the service/resource are compared against the scope included in the introspection response for at least one match between the two sets.

For more information on the underlying module, see the [`oauth2` module](https://lib.ballerina.io/ballerina/oauth2/latest/) 
and [`http` specification](https://ballerina.io/spec/http/#9114-listener---oauth2).

::: code http_service_oauth2.bal :::

Run the service by executing the following command.

::: out http_service_oauth2.server.out :::
