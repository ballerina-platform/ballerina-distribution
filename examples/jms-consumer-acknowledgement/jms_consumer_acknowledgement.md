# JMS message consumer - Manual acknowledgment

The `jms:MessageConsumer` allows manual acknowledgment for received messages. A `jms:MessageConsumer` can be initialized by using a `jms:Session` object. To configure manual acknowledgment mode, create a `jms:Session` object with the acknowledge mode set to `jms:CLIENT_ACKNOWLEDGE`.

::: code jms_consumer_acknowledgement.bal :::

## Prerequisites
Start a [ActiveMQ broker](https://activemq.apache.org/getting-started) instance.

Run the program by executing the following command.

::: out jms_consumer_acknowledgement.out :::

>**Tip:** Run the JMS message producer given in the [JMS message producer - Produce message](/learn/by-example/jms-producer-produce-message) example to produce a few sample messages to the queue.

## Related links
- [`jms:MessageConsumer->acknowledge` function - API documentation](https://lib.ballerina.io/ballerinax/java.jms/latest#MessageConsumer-acknowledge)
- [`jms:MessageConsumer` functions - Specification](https://github.com/ballerina-platform/module-ballerinax-java.jms/blob/master/docs/spec/spec.md#61-functions)
