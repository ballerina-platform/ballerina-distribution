# Kafka client - Payload data binding

The Kafka consumer connects to a given Kafka server, and then receives payloads in a user defined type via data-binding. A Kafka consumer is created by giving the server endpoint, group id and the topic. Once connected, `pollPayload` method is used to receive payloads with the intended type from the Kafka server. The received payload will be bound to the target type internally. The consumer uses the built-in byte array deserializer for the value, which is the default deserializer in the `kafka:Consumer`. Use this to receive only the payload from a Kafka server without the metadata of the payload like `kafka:PartitionOffset` and `timestamp`.

::: code kafka_client_payload_data_binding.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_client_payload_data_binding.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka:Consumer->pollPayload` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Consumer#pollPayload)
- [Kafka client consume messages - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#422-consume-messages)
