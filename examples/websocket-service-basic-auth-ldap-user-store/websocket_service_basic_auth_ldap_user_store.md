# WebSocket service - Basic authentication LDAP user store

The `websocket:Service` can be secured with basic authentication and optionally, by enforcing authorization. This can be achieved by validating the basic authentication token sent in the initial HTTP upgrade request `Authorization` header with the LDAP server. This server stores the usernames and passwords for the authentication and the scopes for the authorization. Confogure the scopes required by the `websocket:Service`  for authorization in the `auth` field of the `@websocket:ServiceConfig` annotation.

A `401 Unauthorized` response is sent to the client when the authentication fails, and a `403 Forbidden` response is sent to the client when the authorization fails. Use this to authenticate and authorize requests based on LDAP user stores. 

::: code websocket_service_basic_auth_ldap_user_store.bal :::

## Prerequisites
- Run the LDAP server.

Run the service by executing the command below.

::: out websocket_service_basic_auth_ldap_user_store.server.out :::

>**Tip:** You can invoke the above service via the [Basic authentication client](/learn/by-example/websocket-client-basic-auth).

## Related Links
- [`websocket` module - API documentation](https://lib.ballerina.io/ballerina/websocket/latest)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
- [WebSocket authentication - Specification](/spec/websocket/#52-authentication-and-authorization)
