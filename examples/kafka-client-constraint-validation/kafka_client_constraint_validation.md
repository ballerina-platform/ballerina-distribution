# Kafka client - Constraint validation

This example shows how to validate a payload by the constraints added to the related payload record. When the payload is received from the broker, it is validated internally and if validation fails, a `kafka:PayloadValidationError` will be returned. To seek past the erroneous record and read the new records, the `seek` API of `kafka:Consumer` can be used. To stop payload validation, the `validation` flag of `kafka:ConsumerConfiguration` can be set to `false`. This can be used when the payload needs to be implicitly validated upon receiving from the broker.

::: code kafka_client_constraint_validation.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_client_constraint_validation.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example with a valid product name (0 < length <= 30), then with an invalid product name and again with a valid product name.

## Related links
- [`kafka:PayloadValidationError` error type - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/errors#PayloadValidationError)
- [`kafka:Consumer->seek` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/clients/Consumer#seek)
- [`kafka` module - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md)
- [`constraint` module - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
