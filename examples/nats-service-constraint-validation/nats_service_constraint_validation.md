# NATS service - Constraint validation

This example shows how the payload is validated related to the constraints added to the payload record. When a payload is not valid, the `onError` remote method of the service is invoked and an error of type `nats:PayloadValidationError` is returned. 

::: code nats_service_constraint_validation.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats_service_constraint_validation.out :::

>**Tip:** You can invoke the above service via the [NATS client](/learn/by-example/nats-basic-pub/) example with a valid product name (0 < length <= 30), then with an invalid product name and again with a valid product name.

## Related links
- [`nats:PayloadValidationError` error type - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/errors#PayloadValidationError)
- [`nats` package - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md)
- [`constraint` package - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
