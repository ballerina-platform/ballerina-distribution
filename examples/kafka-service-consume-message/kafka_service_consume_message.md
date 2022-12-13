# Kafka service - Consume message

Here, a Kafka consumer is used as a listener to a service with automatic offset commits.

::: code kafka_service_consume_message.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_consume_message.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka:Listener` client object - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Listener)
- [Kafka service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#432-usage)
