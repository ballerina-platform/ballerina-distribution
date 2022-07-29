# HTTP 2.0 server push

HTTP/2 server push messages can be sent and received using the Ballerina `http` library. HTTP/2 Server Push messages allow the server to send resources to the client before the client requests for it.

For more information on the underlying module, see the [`http` module](https://docs.central.ballerina.io/ballerina/http/latest/).

::: code http_2_0_service.bal :::

Run the service by executing the following command.

::: out http_2_0_service.out :::

::: code http_client.bal :::

Run the client program by executing the following command.

::: out http_client.out :::
