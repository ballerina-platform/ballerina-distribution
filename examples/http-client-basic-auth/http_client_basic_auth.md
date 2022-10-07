# Client - Basic Auth

A client, which is secured with Basic Auth can be used to connect to a secured service. The client is enriched with the `Authorization: Basic <token>` header by passing the `http:CredentialsConfig` for the `auth` configuration of the client.

For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest/).

>**Tip:** You may need to change the trusted certificate file path in the code below.

::: code http_client_basic_auth.bal :::

Run the client program by executing the command below.

>**Tip:** As a prerequisite to running the client, start a sample service secured with Basic Auth.

::: out http_client_basic_auth.out :::
