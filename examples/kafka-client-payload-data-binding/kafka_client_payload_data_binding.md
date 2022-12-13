# Kafka client - Payload data binding

The payload data-binding allows you to directly bind Kafka messages to subtypes of `anydata`. It does this by using the built-in bytes deserializer for both the key and the value. To use this, directly assign the `pollPayload` method’s return value to the declared variable, which is a subtype of `anydata[]`. If the payload does not match with the defined type, a `kafka:PayloadBindingError` is returned. The `seek` method of the `kafka:Consumer` can be used to seek past the erroneous record and read the new records. Use this to receive messages from a Kafka server without the metadata of the messages like `kafka:PartitionOffset` and `timestamp`. It is important to note that this only works when `kafka:Producer` also uses the built-in bytes serializer for Ballerina.

::: code kafka_client_payload_data_binding.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.
- Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

Run the program by executing the following command.

::: out kafka_client_payload_data_binding.out :::

## Related links
- [`kafka:Consumer->pollPayload` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Consumer#pollPayload)
- [Kafka client consume messages - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#422-consume-messages)
