# Kafka client - Payload data binding

This example shows how to poll messages from the Kafka broker and bind the messages to a user-defined type. Define a required record type to data bind and provide it as the target type for the `pollPayload()` API. The received values will be bound to the target type internally. The consumer uses the built-in byte array deserializer for both the key and the value, which is the default deserializer in the `kafka:Consumer`. Use this API when you only want the payload of the consumer record and do not require metadata like `kafka:PartitionOffset`, or `timestamp`.

::: code kafka_client_payload_data_binding.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.
- Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

Run the program by executing the following command.

::: out kafka_client_payload_data_binding.out :::

## Related links
- [`kafka:Consumer->pollPayload` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Consumer#pollPayload)
- [Kafka client consume messages - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#422-consume-messages)
