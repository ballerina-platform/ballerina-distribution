# RabbitMQ client - Constraint validation

The Ballerina constraint module allows you to add additional constraints to the message content. The constraints can be added to a given data type using different annotations. When a message with a constraint is received from the RabbitMQ server, it is validated internally. This validation happens soon after the successful data-binding of the message content before returning the message record. If the validation fails, the `rabbitmq:PayloadValidationError` error is returned. Use this to validate the message content as the application receives it, which allows you to guard against unnecessary message content processing and malicious content.

::: code rabbitmq_client_constraint_validation.bal :::

## Prerequisites
- Start an instance of the [RabbitMQ server](https://www.rabbitmq.com/download.html).

Run the client program by executing the following command.

::: out rabbitmq_client_constraint_validation.out :::

>**Tip:** You can invoke the above service via the [RabbitMQ client](/learn/by-example/rabbitmq-producer/) example with a valid product name (0 < length <= 30), then with an invalid product name and again with a valid product name.

## Related links
- [`rabbitmq:PayloadValidationError` error type - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest#PayloadValidationError)
- [`rabbitmq` package - API documentation](https://lib.ballerina.io/ballerinax/rabbitmq/latest)
- [`constraint` package - API documentation](https://lib.ballerina.io/ballerina/constraint/latest)
