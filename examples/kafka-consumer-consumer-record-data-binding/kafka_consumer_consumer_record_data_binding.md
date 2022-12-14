# Kafka consumer - Consumer record data binding

The consumer record data-binding allows you to directly bind Kafka messages to subtypes of `kafka:AnydataConsumerRecord`. It does this by using the built-in bytes deserializer for both the key and the value. To use this, directly assign the `poll` method’s return value to the declared variable, which is a subtype of `kafka:AnydataConsumerRecord[]`. A subtype of `kafka:AnydataConsumerRecord` can be created by specifying a user defined type for the value field. If the record does not match with the defined type, a `kafka:PayloadBindingError` is returned. The `seek` method of the `kafka:Consumer` can be used to seek past the erroneous record and read the new records. Use this to receive messages from a Kafka server with the metadata of the messages like `kafka:PartitionOffset` and `timestamp`. It is important to note that this only works when `kafka:Producer` also uses the built-in bytes serializer for Ballerina.

::: code kafka_consumer_consumer_record_data_binding.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_consumer_consumer_record_data_binding.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka:Consumer->poll` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Consumer#poll)
- [Kafka client consume messages - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#422-consume-messages)
