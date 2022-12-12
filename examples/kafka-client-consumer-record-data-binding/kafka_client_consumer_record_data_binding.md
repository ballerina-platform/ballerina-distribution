# Kafka client - Consumer record data binding

The `kafka:Consumer` connects to a given Kafka server, and then receives messages as a `byte[]` or as a user defined type via data-binding. A `kafka:Consumer` is created by giving the server endpoint, group id and the topic. A user-defined type can be created by creating a subtype of `kafka:AnydataConsumerRecord` and overriding the type of `value` field. Once connected, `poll` method is used to receive messages with the intended type from the Kafka server. The received values will be bound to the target type internally. The consumer uses the built-in byte array deserializer for both the key and the value, which is the default deserializer in the `kafka:Consumer`. Use this to receive messages from a Kafka server with the metadata of the messages like `kafka:PartitionOffset` and `timestamp`.

::: code kafka_client_consumer_record_data_binding.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_client_consumer_record_data_binding.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka:Consumer->poll` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Consumer#poll)
- [Kafka client consume messages - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#422-consume-messages)
