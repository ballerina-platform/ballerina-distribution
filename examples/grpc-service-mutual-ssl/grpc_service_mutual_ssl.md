# Service - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

>**Info:** For more information on the underlying module, see the [`grpc` module](https://lib.ballerina.io/ballerina/grpc/latest/).

>**Info:** Setting up the service is the same as setting up the simple RPC service with additional configurations. You can refer to the [simple RPC service](/learn/by-example/grpc-service-simple/) to implement the service used below.

**Tip:** You may need to change the certificate file path, private key file path, and trusted certificate file path in the code below.

   ::: code grpc_service_mutual_ssl.bal :::

Execute the command below to run the service.

   ::: out grpc_service_mutual_ssl.server.out :::

>**Info:** You can invoke the above service via the [sample Mutual SSL client](/learn/by-example/grpc-client-mutual-ssl/).
