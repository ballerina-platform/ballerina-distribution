# Client - Bearer Token Auth

A client, which is secured with Bearer token auth can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:BearerTokenConfig` for the `auth` configuration of the client.

## Generate the service definition

1. Create a new Protocol Buffers definition file named `grpc_client.proto` and add the service definition to it.

   ::: code grpc_client.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

    ::: out grpc_client.out :::

Once you run the command, the `grpc_client_pb.bal` file is generated inside the stubs directory.

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the [Proto To Ballerina](https://ballerina.io/learn/by-example/proto-to-ballerina.html) example.

## Implement and run the client

1. Create a Ballerina package.

2. Copy the generated `grpc_secured_pb.bal` stub file to the package. For example, if you create a package named `client`, copy the stub file to the `client` package.

3. Create a new `grpc_client_bearer_token_auth.bal` Ballerina file inside the `client` package and add the client implementation.

   ::: code grpc_client_bearer_token_auth.bal :::

4. Execute the commands below to build and run the 'client' package.

   ::: out grpc_client_bearer_token_auth.out :::

You may need to change the trusted certificate file path.

As a prerequisite, start a secured sample service.