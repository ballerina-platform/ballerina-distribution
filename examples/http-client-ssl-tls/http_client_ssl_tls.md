# Client - SSL/TLS

You can use the HTTPS client to connect or interact with an HTTPS listener. Provide the `http:ClientSecureSocket` configurations to the client to initiate an HTTPS connection.

For more information on the underlying module, see the [`http` module](https://lib.ballerina.io/ballerina/http/latest/) 
and [`http` specification](https://ballerina.io/spec/http/#923-client---ssltls).

>**Tip:** You may need to change the trusted certificate file path in the code below.

::: code http_client_ssl_tls.bal :::

Run the secure client program by executing the command below.

>**Info:** As a prerequisite to running the client, start a [sample service secured with SSL/TLS](earn/by-example/http-service-ssl-tls/). 

::: out http_client_ssl_tls.out :::
