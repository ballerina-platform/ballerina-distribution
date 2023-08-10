# Kafka service - Error handling

The `kafka:Service` has an `onError` method which is invoked when `kafka:Listener` triggers errors before the `onConsumerRecord` method is invoked. These errors could include payload binding errors or constraint validation errors. In the default behaviour, `kafka:PayloadBindingError`s and `kafka:PayloadValidationError`s are logged to the console and automatically seeked to fetch the next record. To pass these errors to the `onError` method, `autoSeekOnValidationFailure` configuration can be set to `false`. The `onError` method allows the user to handle these errors as needed. If there is no `onError` method in the `kafka:Service`, these are logged to the console with the stack-trace. In addition, `kafka:Service` allows returning errors from the `onConsumerRecord` method. These errors are also logged to the console and the next polling cycle will continue.

::: code kafka_service_error_handling.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_error_handling.out :::

>**Tip:** Run the Kafka client given in the [Kafka producer - Produce message](/learn/by-example/kafka-producer-produce-message) example to produce some messages to the topic.

## Related links
- [`kafka` module - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest)
- [Kafka service - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md#432-usage)
