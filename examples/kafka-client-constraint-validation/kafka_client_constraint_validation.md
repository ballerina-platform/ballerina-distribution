# Kafka client - Constraint validation

This example shows how the payload is validated related to the constraints added to the payload record. When a payload is not valid, `seek` method of `kafka:Consumer` can be used to seek pass the erroneous record and read the new records.

::: code kafka_client_constraint_validation.bal :::

## Prerequisites
- Start a [Kafka broker](https://kafka.apache.org/quickstart) instance.

Run the program by executing the following command.

::: out kafka_client_constraint_validation.out :::

Invoke the service by executing the following cURL commands in a new terminal.

::: out kafka_client_constraint_validation.curl.out :::

>**Tip:** Run the Kafka client given in the [Kafka client - Produce message](/learn/by-example/kafka-client-produce-message) example with an invalid product name and then with a valid product name.

## Related links
- [`kafka:PayloadValidationError` error type - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/errors#PayloadValidationError)
- [`kafka:Consumer->seek` function - API documentation](https://lib.ballerina.io/ballerinax/kafka/3.4.0/clients/Consumer#seek)
- [`kafka` package - Specification](https://github.com/ballerina-platform/module-ballerinax-kafka/blob/master/docs/spec/spec.md)
- [`constraint` package - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
