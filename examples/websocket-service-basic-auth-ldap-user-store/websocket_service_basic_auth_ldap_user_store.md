# WebSocket service - Basic authentication - LDAP user store

A WebSocket service can be secured with Basic authentication and by enforcing authorization optionally. Then, it validates the Basic authentication token sent in the `Authorization` header against the provided configurations. This reads data from the configured LDAP. This stores usernames, passwords for authentication, and scopes for authorization.

Ballerina uses the concept of scopes for authorization. A resource declared in a service can be bound to one/more scope(s). In the authorization phase, the scopes of the service are compared against the scope included in the user store for at least one match between the two sets.

For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest/).

>**Tip:** You may need to change the certificate file path and private key file path in the code below.

::: code websocket_service_basic_auth_ldap_user_store.bal :::

Run the service by executing the cURL command below.

::: out websocket_service_basic_auth_ldap_user_store.server.out :::

>**Info:** Alternatively, you can invoke the above service via the [Basic authentication client](/learn/by-example/websocket-client-basic-auth).
