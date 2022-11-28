# Kafka client - Consumer record data binding

This shows how to use a `kafka:Consumer` as a simple record consumer. The records from a subscribed topic can be retrieved using the `poll()` function. This consumer uses the builtin byte array deserializer for both the key and the value, which is the default deserializer in the `kafka:Consumer`.

The received records are converted to the user defined type using data-binding.

::: code kafka_client_consumer_record_data_binding.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.
- Execute [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic. 

Run the program by executing the following command.

::: out kafka_client_consumer_record_data_binding.out :::

## Related links
- [`kafka:Consumer->poll` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/clients/Consumer#poll)
- [Consume messages - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#422-consume-messages)
