# NATS service - Send reply to request message

NATS supports the Request-Reply pattern using its core message distribution model, publish and subscribe. A request is sent to a given subject and consumers listening to that subject can send responses to the reply subject. In this example, the NATS service is used to send replies to incoming request messages. 

::: code nats-basic-reply.bal :::

To run the sample, start an instance of the NATS server and execute the following command.

::: out nats-basic-reply.out :::

## Related links
- [`nats` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest)
- [`nats:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#4-subscribing)
