# Kafka client - Payload data binding

This shows how to use a `kafka:Consumer` as a simple payload consumer for the instances where the metadata related to the message is not needed. This consumer uses the builtin byte array deserializer for the value and converts the value to the user defined type.

::: code kafka_client_payload_data_binding.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.
- Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

Run the program by executing the following command.

::: out kafka_client_payload_data_binding.out :::

## Related links
- [`kafka:Consumer->pollPayload` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Consumer#pollPayload)
- [Consume messages - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#422-consume-messages)
