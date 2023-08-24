# MQTT service - SSL/TLS

The `mqtt:Service` receives messages from the MQTT server using the `mqtt:Listener` via SSL/TLS. SSL/TLS can be enabled by configuring the `secureSocket`, which requires a certificate or a truststore. Further, mTLS can be enabled by providing a certificate and private key of the service or a keystore. Use this to connect to an MQTT server secured with SSL.

::: code mqtt_service_ssl.bal :::

## Prerequisites
- Start a [MQTT broker](https://mqtt.org/software/) instance configured to use SSL/TLS.

Run the program by executing the following command.

::: out mqtt_service_ssl.out :::

>**Tip:** Run the MQTT client given in the [MQTT client - SSL/TLS](/learn/by-example/mqtt-client-ssl) example to publish some messages to the topic.

## Related links
- [`mqtt:SecureSocket` record - API documentation](https://lib.ballerina.io/ballerina/mqtt/latest#SecureSocket)
- [MQTT secure service - Specification](https://github.com/ballerina-platform/module-ballerina-mqtt/blob/main/docs/spec/spec.md#422-secure-listener)
