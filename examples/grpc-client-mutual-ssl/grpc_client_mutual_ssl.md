# Client - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

>**Info:** For more information on the underlying module, see the [`gRPC` module](https://lib.ballerina.io/ballerina/grpc/latest).

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

3. Create a new `grpc_client_mutual_ssl.bal` Ballerina file inside the `client` package and add the client implementation.

   ::: code grpc_client_mutual_ssl.bal :::

4. Execute the commands below to build and run the 'client' package.

   ::: out grpc_client_mutual_ssl.out :::

You may need to change the certificate file path, private key file path, and trusted certificate file path.

As a prerequisite, start a sample service secured with mutual SSL.