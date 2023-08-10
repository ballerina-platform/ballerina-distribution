# HTTP service - OAuth2

The `http:Service` and resource function can be secured with OAuth2 and additionally, scopes can be added to enforce fine-grained authorization. It validates the OAuth2 token sent in the `Authorization` header against the provided configurations. This calls the configured introspection endpoint to validate. Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the introspection response using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`. In the authorization phase, the scopes of the service/resource are compared against the scope included in the introspection response for at least one match between the two sets.

::: code http_service_oauth2.bal :::

## Prerequisites
- An STS endpoint should be up and running.

Run the service by executing the command below.

::: out http_service_oauth2.server.out :::

>**Tip:** You can invoke the above service via the [OAuth2 JWT Bearer grant type client](/learn/by-example/http-client-oauth2-jwt-bearer-grant-type) example.

## Related links
- [`http:OAuth2IntrospectionConfig` - API documentation](https://lib.ballerina.io/ballerina/http/latest#OAuth2IntrospectionConfig)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [HTTP service oauth2 - Specification](/spec/http/#9114-listener---oauth2)
