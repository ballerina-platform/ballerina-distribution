# Kafka service - Constraint validation

The `kafka:Service` connects to a given Kafka server via the `kafka:Listener`, and then validates the received payloads by the defined constraints. The constraints are added as annotations to the payload record and when the payload is received from the broker, it is validated internally and if validation fails, a `kafka:PayloadBindingError` will be logged to the console and the `kafka:Listener` will be automatically seeked to the next record. This behaviour can be changed by setting `autoSeekOnValidationFailure` configuration to `false`. Then the `onError` remote method will be invoked with the related error to be handled as needed. The `validation` flag of the`kafka:ConsumerConfiguration` can be set to `false` to stop validating the payloads. Use this to validate the messages received from a Kafka server implicitly.

::: code kafka_service_constraint_validation.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_constraint_validation.out :::

>**Tip:** Run the Kafka client given in the [Kafka producer - Produce message](/learn/by-example/kafka-producer-produce-message) example with a valid product name (0 < length <= 30), then with an invalid product name and again with a valid product name.

## Related links
- [`kafka:PayloadValidationError` error type - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/errors#PayloadValidationError)
- [`kafka:Caller->seek` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Caller#seek)
- [`kafka` module - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md)
- [`constraint` module - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
