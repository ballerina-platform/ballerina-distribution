# Kafka service - Constraint validation

The Kafka service connects to a given Kafka server via the Kafka listener, and then validates the received payloads by the defined constraints. The constraints are added as annotations to the payload record and when the payload is received from the broker, it is validated internally and if validation fails, the `onError` remote method will be invoked with a `kafka:PayloadValidationError`. The `seek` method of the Kafka caller is used to seek past the erroneous record and read the new records. The `validation` flag of the`kafka:ConsumerConfiguration` can be set to `false` to stop validating the payloads. Use this to validate the messages received from a Kafka server implicitly.

::: code kafka_service_constraint_validation.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_constraint_validation.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example with a valid product name (0 < length <= 30), then with an invalid product name and again with a valid product name.

## Related links
- [`kafka:PayloadValidationError` error type - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/errors#PayloadValidationError)
- [`kafka:Caller->seek` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Caller#seek)
- [`kafka` module - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md)
- [`constraint` module - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
