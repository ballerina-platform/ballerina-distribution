# Kafka service - Consume message

The `kafka:Service` connects to a given Kafka server via the `kafka:Listener`, and then receives payloads in a user defined-type using data-binding. A `kafka:Listener` is created by giving the server-endpoint, group-id, and topic, and then the `kafka:Service` is attached to the listener. The required payload type is provided as the target type to the `onConsumerRecord` method to data bind internally. When new messages are received, the `onConsumerRecord` method gets invoked. The offsets will be automatically committed as the `autocommit` config in `kafka:ConsumerConfiguration` is enabled by default. The `commit` method of `kafka:Caller` is used to commit the offsets manually. `kafka:Caller` can be added as a second argument in the `onConsumerRecord` method. Use this to listen to a set of topics in a Kafka server and receive messages implicitly.

::: code kafka_service_consume_message.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_consume_message.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka:Listener` client object - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Listener)
- [Kafka service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#432-usage)
