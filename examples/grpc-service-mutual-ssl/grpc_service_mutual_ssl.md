# Service - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication
process in which two parties (the client and server) authenticate each other by
verifying the digital certificates. It ensures that both parties are assured
of each other's identity.

For more information on the underlying module, 
see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

::: code grpc_service.proto :::

Create a new Protocol Buffers definition file named `grpc_service.proto` and add the service definition to it.
Run the command below in the Ballerina tools distribution for stub generation.

Once you run the command, the `grpc_service_pb.bal` file is generated inside the stubs directory.

For more information on how to use the Ballerina Protocol Buffers tool, see the <a href="https://ballerina.io/learn/by-example/proto-to-ballerina.html">Proto To Ballerina</a> example.

::: out grpc_service.out :::

::: code grpc_service_mutual_ssl.bal :::

Create a Ballerina package.
Copy the generated `grpc_secured_pb.bal` stub file to the package.
For example, if you create a package named `service`, copy the stub file to the `service` package.

Create a new `grpc_service_mutual_ssl.bal` Ballerina file inside the `service` package and add the service implementation.

Execute the commands below to build and run the 'service' package.
You may need to change the certificate file path, private key file path, and
trusted certificate file path.

::: out grpc_service_mutual_ssl.server.out :::
