# Kafka service - Consume message

The `kafka:Service` connects to a given Kafka server via the `kafka:Listener`, and allows to directly bind Kafka messages to subtypes of `anydata`. It does this by using the built-in bytes deserializer for both the key and the value. To use this, provide the required payload type as the argument type to the `onConsumerRecord` method, which is a subtype of `anydata[]`. When new messages are received, the `onConsumerRecord` method gets invoked. If the payload does not match the defined type, a `kafka:PayloadBindingError` will be logged to the console and the `kafka:Listener` will be automatically seeked to the next record. This behaviour can be changed by setting `autoSeekOnValidationFailure` configuration to `false`. Then the `onError` remote method will be invoked with the related error to be handled as needed. Use this to listen to a set of topics in a Kafka server and receive messages implicitly.

::: code kafka_service_consume_message.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_consume_message.out :::

>**Tip:** Run the Kafka client given in the [Kafka producer - Produce message](/learn/by-example/kafka-producer-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka:Listener` client object - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Listener)
- [Kafka service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#432-usage)
