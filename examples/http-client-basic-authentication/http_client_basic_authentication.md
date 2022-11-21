# HTTP client - Basic authentication

A client, which is secured with Basic Auth can be used to connect to a secured service. The client is enriched with the `Authorization: Basic <token>` header by passing the `http:CredentialsConfig` for the `auth` configuration of the client.

For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest/) and [`http` specification](https://ballerina.io/spec/http/#9115-client---basic-auth).

>**Tip:** You may need to change the trusted certificate file path in the code below.

::: code http_client_basic_authentication.bal :::

Run the client program by executing the command below.

>**Info:** As a prerequisite to running the client, start the [Basic authentication file user store service](/learn/by-example/http-service-basic-authentication-file-user-store).

::: out http_client_basic_authentication.out :::
