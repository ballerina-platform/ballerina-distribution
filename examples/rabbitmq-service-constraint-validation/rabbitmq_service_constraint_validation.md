# RabbitMQ service - Constraint validation

This example shows how to validate a payload by the constraints added to the related message record. When a message with a constraint is received from the RabbitMQ server, it is validated internally. If the validation fails, the `onError` remote method is invoked with a `rabbitmq:PayloadValidationError`. Payload validation using constraints can be used when the message content needs to be implicitly validated upon receiving from the server.

::: code rabbitmq_service_constraint_validation.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html). 

Run the service by executing the following command.

::: out rabbitmq_service_constraint_validation.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/) example with a valid product name (0 < length <= 30), then with an invalid product name and again with a valid product name.

## Related links
- [`rabbitmq:PayloadValidationError` error type - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest/errors#PayloadValidationError)
- [`rabbitmq` package - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [`constraint` package - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
