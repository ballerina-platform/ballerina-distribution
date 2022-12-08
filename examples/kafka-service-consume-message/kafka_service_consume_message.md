# Kafka service - Consume message

This example shows how a `kafka:Listener` is used with a `kafka:Service` to listen to new messages in a topic. Create a `kafka:Listener` with default configurations and attach it to a `kafka:Service`. Provide the required payload type as the target type to the `onConsumerRecord` method to data bind internally. When new messages are received, the `onConsumerRecord` method will get invoked. Here, the offsets will be automatically committed. If you need to commit manually, disable `autoCommit` in `kafka:ConsumerConfiguration` and use the `commit()` API of `kafka:Caller`. To use `kafka:Caller`, add it as a second argument in the `onConsumerRecord` method. Use this when you need to listen to a Kafka topic and receive messages implicitly.

::: code kafka_service_consume_message.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.
- Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

Run the program by executing the following command.

::: out kafka_service_consume_message.out :::

## Related links
- [`kafka:Listener` client object - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Listener)
- [Kafka service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#432-usage)
