# GraphQL service - OAuth2

A GraphQL service can be secured with OAuth2 and by enforcing authorization optionally. Then, it validates the OAuth2 token sent in the `Authorization` header against the provided configurations. This calls the configured introspection endpoint to validate. Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). The scope can be included in the introspection response using a custom claim attribute. That custom claim attribute also can be configured as the `scopeKey`. In the authorization phase, the scopes of the service are compared against the scope included in the introspection response for at least one match between the two sets.

::: code graphql_service_oauth2.bal :::

## Prerequisites
- An STS endpoint should be up and running.

Run the service by executing the command below.

::: out graphql_service_oauth2.server.out :::

>**Tip:** You can invoke the above service via the [GraphQL client - OAuth2 password grant type](/learn/by-example/graphql-client-security-oauth2-password-grant-type/) example.

## Related links
- [`graphql:ServiceConfig` annotation - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/annotations#ServiceConfig)
- [`graphql:OAuth2IntrospectionConfigWithScopes` record - API documentation](https://lib.ballerina.io/ballerina/graphql/latest/records/OAuth2IntrospectionConfigWithScopes)
- [`oauth2` module - API documentation](https://lib.ballerina.io/ballerina/oauth2/latest/)
- [GraphQL service OAuth2 - Specification](/spec/graphql/#11114-oauth2)
