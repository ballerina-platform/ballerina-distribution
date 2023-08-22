# MQTT client - Publish message

The `mqtt:Client` connects to a given MQTT server, and then publishes messages to a specific topic in the server. A `mqtt:CLient` is created by giving the MQTT server url and a unique ID. Once connected, `publish` method is used to send messages to the MQTT server by providing the relevant topic and the message as the parameters. Use this to send messages to a topic in the MQTT server.

::: code mqtt_client_publish_message.bal :::

## Prerequisites
- Start a [MQTT broker](https://mqtt.org/software/) instance.

Run the program by executing the following command.

::: out mqtt_client_publish_message.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out mqtt_client_publish_message.curl.out :::

## Related links
- [`mqtt:Client->publish` function - API documentation](https://lib.ballerina.io/ballerina/mqtt/latest#Client-publish)
- [`mqtt:Client` functions - Specification](https://github.com/ballerina-platform/module-ballerina-mqtt/blob/master/docs/spec/spec.md#33-functions)
