# Client - Basic Auth

A client, which is secured with Basic Auth can be used to connect to a secured service. The client is enriched with the `Authorization: Basic <token>` header by passing the `http:CredentialsConfig` for the `auth` configuration of the client.

For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest/) 
and [`http` specification](https://ballerina.io/spec/http/#9115-client---basic-auth).

::: code http_client_basic_auth.bal :::

Run the client program by executing the following command.

::: out http_client_basic_auth.out :::
