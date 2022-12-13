# Kafka service - Consume message

The `kafka:Service` connects to a given Kafka server via the `kafka:Listener`, and allows to directly bind Kafka messages to subtypes of `anydata`. It does this by using the built-in bytes deserializer for both the key and the value. To use this, provide the required payload type as the argument type to the `onConsumerRecord` method, which is a subtype of `anydata[]`. When new messages are received, the `onConsumerRecord` method gets invoked. If the payload does not match the defined type, the `onError` remote method will be invoked with a `kafka:PayloadBindingError`. Then, the `seek` method of the `kafka:Caller` can be used to seek past the erroneous record and read the new records. Use this to listen to a set of topics in a Kafka server and receive messages implicitly.

::: code kafka_service_consume_message.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_consume_message.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka:Listener` client object - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Listener)
- [Kafka service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#432-usage)
