# Service - SSL/TLS

You can use the HTTPS listener to connect to or interact with an HTTPS client. Provide the `http:ListenerSecureSocket` configurations to the server to expose an HTTPS connection.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/).

>**Tip:** You may need to change the certificate file path and private key file path in the code below.

::: code http_service_ssl_tls.bal :::

Run the service by executing the command below.

::: out http_service_ssl_tls.server.out :::

Invoke the service by executing the cURL command below. 

::: out http_service_ssl_tls.client.out :::
