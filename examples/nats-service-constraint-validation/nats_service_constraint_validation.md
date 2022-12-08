# NATS service - Constraint validation

This example shows how to validate a payload by the constraints added to the related message record. When a message with a constraint is received from the NATS server, it is validated internally. If the validation fails, the `onError` remote method is invoked with a `nats:PayloadValidationError`. Payload validation using constraints can be used when the message content needs to be implicitly validated upon receiving from the server.

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
