# WebSocket client - Basic authentication

The `websocket:Client` can be secured with Basic authentication by enriching the initial HTTP request from the client with the `Authorization: Basic <token>` header. The username and password for basic authentication can be specified in the `auth` field of the client configuration. Use this to communicate with the service, which is secured with basic authentication.

::: code websocket_client_basic_auth.bal :::

## Prerequisites
- Run the WebSocket service given in the [Basic authentication file user store](/learn/by-example/websocket-service-basic-auth-file-user-store/) example.

Run the client program by executing the command below.

::: out websocket_client_basic_auth.out :::

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
