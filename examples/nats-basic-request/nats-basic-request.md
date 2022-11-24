# NATS client - Send request message

NATS supports the Request-Reply pattern using its core message distribution model, publish and subscribe. A request is sent to a given subject and consumers listening to that subject can send responses to the reply subject. In this example, the NATS client is used to send a request to a subject.

::: code nats-basic-request.bal :::

To run the sample, start an instance of the NATS server and execute the following command.

::: out nats-basic-request.out :::

## Related links
- [`nats:Client` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/clients/Client)
- [`nats:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#3-publishing)
