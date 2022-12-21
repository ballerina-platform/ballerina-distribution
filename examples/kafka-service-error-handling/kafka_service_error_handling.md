# Kafka service - Error handling

When the `kafka:Service` encounters an internal error before invoking the `onConsumerRecord` method, such as a payload binding error or a constraint validation error, the `onError` method will be invoked with the relevant error. This error can be handled according to the user's need inside the `onError` method. If an error is returned from the `onConsumerRecord` method, it will be logged to the console, and the next polling cycle will continue.

::: code kafka_service_error_handling.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_error_handling.out :::

>**Tip:** Run the Kafka client given in the [Kafka producer - Produce message](/learn/by-example/kafka-producer-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka` module - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest)
- [Kafka service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#432-usage)
