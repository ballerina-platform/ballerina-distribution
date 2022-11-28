# Kafka service - Constraint validation

This example shows how the payload is validated related to the constraints added to the payload record. When a payload fails to validate, `seek` api of `kafka:Caller` can be used to seek past the erroneous record and read new records.

::: code kafka_service_constraint_validation.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_constraint_validation.out :::

> **Tip** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example with a valid product name (0 < length <= 30), then with an invalid product name and again with a valid product name.

## Related links
- [`kafka:PayloadValidationError` error type - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/errors#PayloadValidationError)
- [`kafka:Caller->seek` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Caller#seek)
- [`kafka` package - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md)
- [`constraint` package - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
