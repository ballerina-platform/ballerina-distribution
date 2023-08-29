# JMS message producer - Produce message

The `jms:MessageConsumer` allows fetching individual messages one by one from a given JMS provider. A `jms:MessageConsumer` can be initialized by using a `jms:Session` object. To pull messages from the JMS provider use `receive` or `receiveNoWait` methods. It is possible to use automatic or manual acknowledgments similar to consumer service. Use it to pull messages one by one from a JMS destination in the JMS provider.

::: code jms_service_consume_message.bal :::

## Prerequisites
- Start a [ActiveMQ broker](https://activemq.apache.org/getting-started) instance.

Run the program by executing the following command.

::: out jms_service_consume_message.out :::

## Related links
- [`jms:MessageConsumer->receive` function - API documentation](https://lib.ballerina.io/ballerinax/java.jms/latest#MessageConsumer-receive)
- [`jms:MessageConsumer->receiveNoWait` function - API documentation](https://lib.ballerina.io/ballerinax/java.jms/latest#MessageConsumer-receiveNoWait)
- [`jms:MessageConsumer` functions - Specification](https://github.com/ballerina-platform/module-ballerinax-java.jms/blob/master/docs/spec/spec.md#61-functions)
