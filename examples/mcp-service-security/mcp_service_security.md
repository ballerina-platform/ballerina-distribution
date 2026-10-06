# Model Context Protocol (MCP) service security

An MCP service that uses the Streamable HTTP transport is secured like an `http:Service`. Configure TLS with `secureSocket` on the listener. Configure authentication and authorization with the `auth` field of `httpConfig` in the `@mcp:StreamableHttpServiceConfig` annotation. JWT, OAuth2 introspection, and basic authentication with a file or LDAP user store are supported.

This example secures an MCP service with TLS and JWT authentication, and rejects requests that lack a valid JWT or the required scope in the `scp` claim before the tool runs.

::: code mcp_service_security.bal :::

Run the service by executing the command below.

::: out mcp_service_security.server.out :::

Invoke the service using the cURL commands below. The first request carries a JWT with the `admin` scope, the second a JWT with the `developer` scope only, and the third no JWT.

::: out mcp_service_security.client.out :::

## Related links

- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP tools with HTTP request binding example](/learn/by-example/mcp-service-http-request-binding/)
- [`http:ListenerAuthConfig` type - API documentation](https://lib.ballerina.io/ballerina/http/latest#ListenerAuthConfig)
- [`jwt` module - API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
