# Client - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication
process in which two parties (the client and server) authenticate each other by
verifying the digital certificates. It ensures that both parties are assured of each other's identity.

For more information on the underlying module, 
see the [gRPC module](https://lib.ballerina.io/ballerina/grpc/latest).

::: code grpc_client.proto :::

Create a new Protocol Buffers definition file named `grpc_client.proto` and add the service definition to it.
Run the command below in the Ballerina tools distribution for stub generation.

Once you run the command, `grpc_client_pb.bal` file is generated inside stubs directory.

For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

::: out grpc_client.out :::

::: code grpc_client_mutual_ssl.bal :::

Create a Ballerina package.
Copy the generated `grpc_secured_pb.bal` stub file to the package.
For example, if you create a package named `client`, copy the stub file to the `client` package.

Create a new `grpc_client_mutual_ssl.bal` Ballerina file inside the `client` package and add the client implementation.

Execute the commands below to build and run the 'client' package.
You may need to change the certificate file path, private key file path, and trusted certificate file path.

As a prerequisite, start a sample service secured with mutual SSL.

::: out grpc_client_mutual_ssl.out :::
