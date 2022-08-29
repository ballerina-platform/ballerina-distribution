# Service - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

## Generate the service definition

1. Create a new Protocol Buffers definition file named `grpc_service.proto` and add the service definition to it.

    ::: code grpc_service.proto :::

2. Run the command below in the Ballerina tools distribution for stub generation.

    ::: out grpc_service.out :::

Once you run the command, the `grpc_service_pb.bal` file is generated inside the stubs directory.

>**Info:** For more information on how to use the Ballerina Protocol Buffers tool, see the [Proto To Ballerina](https://ballerina.io/learn/by-example/proto-to-ballerina.html) example.

## Implement and run the service

1. Create a Ballerina package.

2. Copy the generated `grpc_secured_pb.bal` stub file to the package. For example, if you create a package named `service`, copy the stub file to the `service` package.

3. Create a new `grpc_service_mutual_ssl.bal` Ballerina file inside the `service` package and add the service implementation.

   ::: code grpc_service_mutual_ssl.bal :::

4. Execute the commands below to build and run the `service` package.

   ::: out grpc_service_mutual_ssl.server.out :::

You may need to change the certificate file path, private key file path, and trusted certificate file path.