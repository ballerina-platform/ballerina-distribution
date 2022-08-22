# Client - Bearer Token Auth

A client, which is secured with Bearer token auth can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:BearerTokenConfig` for the `auth` configuration of the client.

4. Execute the commands below to build and run the 'client' package.

   ::: out grpc_client_bearer_token_auth.out :::

You may need to change the trusted certificate file path.

As a prerequisite, start a secured sample service.
