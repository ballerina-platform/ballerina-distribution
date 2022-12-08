# Kafka service - Constraint validation

This example shows how to validate a payload by the constraints added to the related payload record. When the payload is received from the broker, it is validated internally and if validation fails, the `onError` remote method will be invoked with a `kafka:PayloadValidationError`. To seek past the erroneous record and read the new records, the `seek` API of `kafka:Caller` can be used. To stop payload validation, `validation` flag of `kafka:ConsumerConfiguration` can be set to `false`. This can be used when the payload needs to be implicitly validated upon receiving from the broker.

::: code kafka_service_constraint_validation.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_service_constraint_validation.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example with a valid product name (0 < length <= 30), then with an invalid product name and again with a valid product name.

## Related links
- [`kafka:PayloadValidationError` error type - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/errors#PayloadValidationError)
- [`kafka:Caller->seek` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/latest/clients/Caller#seek)
- [`kafka` package - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md)
- [`constraint` package - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
