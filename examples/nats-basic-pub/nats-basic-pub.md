# NATS client - Publish message

NATS implements a publish-subscribe message distribution model. A publisher sends a message to a subject and any active subscriber listening to that subject can consume the message. In this example, the NATS client is used to produce a message to a subject.

::: code nats-basic-pub.bal :::

To run the sample, start an instance of the NATS server and execute the following command. 

::: out nats-basic-pub.out :::

## Related links
- [`nats:Client` - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/clients/Client)
- [`nats:Client` - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#3-publishing)
