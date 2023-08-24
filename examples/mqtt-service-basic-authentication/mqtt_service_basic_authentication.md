# MQTT service - Basic authentication

The `mqtt:Service` receives messages from the MQTT server using the `mqtt:Listener` via basic authentication. Basic authentication can be enabled by configuring the `username`, `password` in the `connectionConfig` of the `mqtt:ListenerConfiguration`. Use this to connect to an MQTT server secured with basic authentication.

::: code mqtt_service_basic_authentication.bal :::

## Prerequisites
- Start a [MQTT broker](https://mqtt.org/software/) instance configured to use basic authentication.

Run the program by executing the following command.

::: out mqtt_service_basic_authentication.out :::

>**Tip:** Run the MQTT client given in the [MQTT publisher - Basic authentication](/learn/by-example/mqtt-client-basic-authentication) example to produce some messages to the topic.

## Related links
- [`mqtt:ListenerConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/mqtt/latest#ListenerConfiguration)
- [MQTT service basic authentication - Specification](/spec/mqtt/#422-secure-listener)
