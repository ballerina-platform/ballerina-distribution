# HTTP service - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

::: code http_service_mutual_ssl.bal :::

Run the service by executing the command below.

::: out http_service_mutual_ssl.server.out :::

Invoke the service by executing the cURL command below.

::: out http_service_mutual_ssl.client.out :::

>**Info:** You can invoke the above service via the [Mutual SSL/TLS client](/learn/by-example/http-client-mutual-ssl/).

## Related links
- [`http:ListenerSecureSocket` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/ListenerSecureSocket)
- [HTTP service mutual SSL - Secification](/spec/http/#922-listener---mutual-ssl)
