# Kafka service - Error handling

The `kafka:Service` has an `onError` method that is called when an internal error occurs before the `onConsumerRecord` method is called. These errors could include payload binding errors or constraint validation errors. The `onError` method allows the user to handle the error as needed. If an error is returned from the `onConsumerRecord` method, it is logged to the console, and the next polling cycle continues.

::: code kafka_service_error_handling.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_error_handling.out :::

>**Tip:** Run the Kafka client given in the [Kafka producer - Produce message](/learn/by-example/kafka-producer-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka` module - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest)
- [Kafka service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#432-usage)
