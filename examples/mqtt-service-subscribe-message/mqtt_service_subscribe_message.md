# MQTT service - Subscribe to messages

The `mqtt:Service` connects to a given MQTT server via the `mqtt:Listener`, and allows to receive messages from different topics. Once subscribed to a topic, when new messages are received, the `onMessage` method gets invoked. If there are errors when invoking the method, the `onError` remote method will be invoked with the relevant `error`. If the method is not implemented, the error will be logged to the console. Use this to receive messages from a set of topics in a MQTT server.

::: code mqtt_service_subscribe_message.bal :::

## Prerequisites
- Start a [MQTT broker](https://mqtt.org/software/) instance.

Run the program by executing the following command.

::: out mqtt_service_subscribe_message.out :::

>**Tip:** Run the MQTT client given in the [MQTT client - Publish message](/learn/by-example/mqtt-client-publish-message) example to publish some messages to the topic.

## Related links
- [`mqtt:Listener` client object - API documentation](https://lib.ballerina.io/ballerina/mqtt/latest#Listener)
- [MQTT service - Specification](https://github.com/ballerina-platform/module-ballerina-mqtt/blob/main/docs/spec/spec.md#43-usage)
