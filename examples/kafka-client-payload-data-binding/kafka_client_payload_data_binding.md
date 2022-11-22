# Kafka client - Payload data binding

This shows how to use a `kafka:Consumer` as a simple payload consumer for the instances where the metadata related to the message is not needed. This consumer uses the builtin byte array deserializer for the value and converts the value to the user defined type. For this to work properly, an active Kafka broker should be present.

>**Info:** For more information on the underlying module, see the [`kafka` module](https://lib.ballerina.io/ballerinax/kafka/latest).

::: code kafka_client_payload_data_binding.bal :::

::: out kafka_client_payload_data_binding.out :::
