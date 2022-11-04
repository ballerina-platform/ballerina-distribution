# Service - mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) 
and [`http` specification](https://ballerina.io/spec/http/#922-listener---mutual-ssl).

>**Tip:** You may need to change the certificate file path, private key file path, and trusted certificate file path in the code below.

::: code http_service_mutual_ssl.bal :::

Run the service by executing the command below.

::: out http_service_mutual_ssl.server.out :::

Invoke the service by executing the cURL command below.

::: out http_service_mutual_ssl.client.out :::

>**Info:** Alternatively, you can invoke the above service via the [sample Mutual SSL/TLS client](/learn/by-example/http-client-mutual-ssl/).
