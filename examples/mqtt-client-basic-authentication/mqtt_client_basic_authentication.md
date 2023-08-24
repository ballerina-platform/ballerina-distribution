# MQTT client - Basic authentication

The `mqtt:Client` connects to an MQTT server via basic authentication and then, sends messages to the server. Basic authentication can be enabled by configuring the `username`, `password` in the `connectionConfig` of the `mqtt:ClientConfiguration`. Use this to connect to an MQTT server secured with basic authentication.

::: code mqtt_client_basic_authentication.bal :::

## Prerequisites
- Start a [MQTT broker](https://mqtt.org/software/) instance configured to use basic authentication.
- Run the MQTT service given in the [MQTT service - Basic authentication](/learn/by-example/mqtt-service-basic-authentication) example.

Run the program by executing the following command.

::: out mqtt_client_basic_authentication.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out mqtt_client_basic_authentication.curl.out :::

## Related links
- [`mqtt:ClientConfiguration` record - API documentation](https://lib.ballerina.io/ballerina/mqtt/latest#ClientConfiguration)
- [MQTT client basic authentication - Specification](/spec/mqtt/#322-secure-client)
