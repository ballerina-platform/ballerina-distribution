# Kafka client - Consumer record data binding

This example shows how to poll records from the Kafka broker and bind the record values to a user-defined type. Define a required record type to data bind and create a subtype of the `kafka:AnydataConsumerRecord` by providing the type of the `value` field as the created record type. The records from the subscribed topic can be retrieved using the `poll()` function. The received values will be bound to the target type internally. The consumer uses the built-in byte array deserializer for both the key and the value, which is the default deserializer in the `kafka:Consumer`. Use this API when you want the metadata like `kafka:PartitionOffset` and `timestamp` of the message as well.

::: code kafka_client_consumer_record_data_binding.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.
- Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic. 

Run the program by executing the following command.

::: out kafka_client_consumer_record_data_binding.out :::

## Related links
- [`kafka:Consumer->poll` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Consumer#poll)
- [Kafka client consume messages - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#422-consume-messages)
