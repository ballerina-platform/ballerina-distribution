# HTTP service - Mutual SSL

The `http:Listener` with mutual SSL (mTLS) enabled in it allows exposing a connection secured with mutual SSL, which is a certificate-based authentication process in which two parties (the client and server) authenticate each other by verifying the digital certificates. It ensures that both parties are assured of each other's identity. The `http:Listener` secured with mutual SSL is created by providing the `secureSocket` configurations, which require the word `require` as the `verifyClient`, the server's public certificate as the `certFile`, the server's private key as the `keyFile`, and the client's certificate as the `cert`. Use this to secure the HTTP connection over mutual SSL.

::: code http_service_mutual_ssl.bal :::

Run the service by executing the command below.

::: out http_service_mutual_ssl.server.out :::

Invoke the service by executing the cURL command below.

::: out http_service_mutual_ssl.client.out :::

>**Tip:** You can invoke the above service via the [Mutual SSL/TLS client](/learn/by-example/http-client-mutual-ssl/) example.

## Related links
- [`http:ListenerSecureSocket` - API documentation](https://lib.ballerina.io/ballerina/http/latest/records/ListenerSecureSocket)
- [HTTP service mutual SSL - Secification](/spec/http/#922-listener---mutual-ssl)
