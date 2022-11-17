# Client - Basic Auth

A client, which is secured with Basic Auth can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Basic <token>` header by passing the `grpc:CredentialsConfig` for the `auth` configuration of the client.

>**Info:** For more information on the underlying module, see the [`auth` module](https://lib.ballerina.io/ballerina/auth/latest).

>**Info:** Setting up the client is the same as setting up the simple RPC client with additional configurations. You can refer to the [simple RPC client](/learn/by-example/grpc-client-simple/) to implement the client used below.

   ::: code grpc_client_basic_auth.bal :::

Execute the command below to run the client. You may need to change the trusted certificate file path.

>**Info:** As a prerequisite to running the client, start the [Basic Auth file user store service](/learn/by-example/grpc-service-basic-auth-file-user-store/) or [Basic Auth LDAP user store service](/learn/by-example/grpc-service-basic-auth-ldap-user-store/).

   ::: out grpc_client_basic_auth.out :::
