# HTTP client - Mutual SSL

Ballerina supports mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity.

::: code http_client_mutual_ssl.bal :::

## Prerequisites
- Run the HTTP service given in the [Mutual SSL service](/learn/by-example/http-service-mutual-ssl/).

Run the client program by executing the command below.

::: out http_client_mutual_ssl.out :::

## Related links
- [`http:ClientSecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/ClientSecureSocket)
- [HTTP client mutual SSL - Specification](/spec/http/#924-client---mutual-ssl)
