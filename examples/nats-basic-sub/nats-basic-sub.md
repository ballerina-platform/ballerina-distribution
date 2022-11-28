# NATS service - Consume message

NATS implements a publish-subscribe message distribution model. A publisher sends a message to a subject and any active subscriber listening to that subject can consume the message. In this example, the NATS service is used to consume messages from a subject. 

::: code nats-basic-sub.bal :::

To run the sample, start an instance of the NATS server and execute the following command.

::: out nats-basic-sub.out :::

## Related links
- [`nats` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest)
- [`nats:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#4-subscribing)
