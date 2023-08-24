# MQTT client - SSL/TLS

The `mqtt:Client` connects to an MQTT server via SSL/TLS and then, sends messages to the server. SSL/TLS can be enabled by configuring the `secureSocket`, which requires a certificate or a truststore. Further, mTLS can be enabled by providing a certificate and private key of the client or a keystore. Use this to connect to an MQTT server secured with SSL.

>**Info:** For more information on the underlying module, see the [`mqtt` module](https://lib.ballerina.io/ballerina/mqtt/latest).

::: code mqtt_client_ssl.bal :::

## Prerequisites
- Start a [MQTT broker](https://mqtt.org/software/) instance configured to use SSL/TLS.
- Run the MQTT service given in the [MQTT service - SSL/TLS](/learn/by-example/mqtt-service-ssl) example.

Run the program by executing the following command.

::: out mqtt_client_ssl.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out mqtt_client_ssl.curl.out :::

## Related links
- [`mqtt:SecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/mqtt/latest#SecureSocket)
- [MQTT secure client - Specification](/spec/mqtt/#322-secure-client)
