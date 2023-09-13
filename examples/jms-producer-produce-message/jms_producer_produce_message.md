# JMS message producer - Produce messages

The `jms:MessageProducer` connects to a given JMS provider, and then sends messages to a specific JMS destination (queue or a topic) in the JMS provider. 
A `jms:MessageProducer` can be initialized by using a `jms:Session` object. Once connected, the `send` method can be used to send messages to a JMS destination in the JMS provider. `jms:TextMessage`, `jms:BytesMessage`, and `jms:MapMesage` can be provided as messages. Use this to send messages to a specific JMS destination. 
The `sentTo` method of the `jms:MessageProducer` is used to send messages to multiple JMS destinations.

::: code jms_producer_produce_message.bal :::

## Prerequisites
Start a [ActiveMQ broker](https://activemq.apache.org/getting-started) instance.

Run the program by executing the following command.

::: out jms_producer_produce_message.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out jms_producer_produce_message.curl.out :::

## Related links
- [`jms:MessageProducer->send` function - API documentation](https://lib.ballerina.io/ballerinax/java.jms/latest#MessageProducer-send)
- [`jms:MessageProducer->sendTo` function - API documentation](https://lib.ballerina.io/ballerinax/java.jms/latest#MessageProducer-sendTo)
- [`jms:MessageProducer` functions - Specification](https://github.com/ballerina-platform/module-ballerinax-java.jms/blob/master/docs/spec/spec.md#51-functions)
