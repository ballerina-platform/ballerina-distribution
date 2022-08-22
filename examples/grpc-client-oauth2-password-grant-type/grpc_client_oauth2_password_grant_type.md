# Client - OAuth2 Password grant type

A client, which is secured with OAuth2 password grant type can be used to connect to a secured service.

The client metadata is enriched with the `Authorization: Bearer <token>` header by passing the `grpc:OAuth2PasswordGrantConfig` to the `auth` configuration of the client.

For more information on the underlying module, see the [OAuth2 module](https://lib.ballerina.io/ballerina/oauth2/latest/).

1. Create a Ballerina package.
   
2. Copy the generated `grpc_secured_pb.bal` stub file to the package. For example, if you create a package named `client`, copy the stub file to the `client` package.

3. Create a new `grpc_client_oauth2_password_grant_type.bal` Ballerina file inside the `client` package and add the client implementation.

   ::: code grpc_client_oauth2_password_grant_type.bal :::
   
4. Execute the commands below to build and run the 'client' package.
   
   ::: out grpc_client_oauth2_password_grant_type.out :::
   
You may need to change the trusted certificate file path.

As a prerequisite, start a sample service secured with OAuth2.
