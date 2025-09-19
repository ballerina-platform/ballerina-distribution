# JMS service - Consume messages

The `jms:Service` connects to a given JMS provider via the `jms:Listener`, and allows receiving messages asynchronously. A `jms:Listener` is initialized by providing the connection configurations. A `jms:Service` must be configured to subscribe to a JMS destination—either a queue or a topic—using the `jms:ServiceConfig` annotation. Use this to listen to messages sent to a particular JMS destination asynchronously.


::: code jms_service_consume_message.bal :::

## Prerequisites
Start a [ActiveMQ broker](https://activemq.apache.org/getting-started) instance.

Run the program by executing the following command.

::: out jms_service_consume_message.out :::

>**Tip:** Run the JMS message producer given in the [JMS message producer - Produce message](/learn/by-example/jms-producer-produce-message) example to produce some messages to the queue.

## Related links
- [`jms:Listener` - API documentation](https://lib.ballerina.io/ballerinax/java.jms/latest#Listener)
- [`jms:Listener` - Specification](https://github.com/ballerina-platform/module-ballerinax-java.jms/blob/master/docs/spec/spec.md#7-message-listener)
