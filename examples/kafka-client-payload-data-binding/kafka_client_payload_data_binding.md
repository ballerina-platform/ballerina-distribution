# Kafka client - Payload data binding

This shows how to use a `kafka:Consumer` as a simple payload consumer for the instances where the metadata related to the message is not needed. This consumer uses the builtin byte array deserializer for the value and converts the value to the user defined type. For this to work properly, an active Kafka broker should be present.

::: code kafka_client_payload_data_binding.bal :::

::: out kafka_client_payload_data_binding.out :::

## Related links
- [`kafka:pollPayload` - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/clients/Consumer#pollPayload)
- [Consume messages - specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#422-consume-messages)
