# NATS client - Publish message

NATS implements a publish-subscribe message distribution model. A publisher sends a message to a subject and any active subscriber listening to that subject can consume the message. In this example, the NATS client is used to produce a message to a subject.

::: code nats-basic-pub.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).
- Run the NATS service given in the [NATS service - Consume message](/learn/by-example/nats-basic-sub/) example.

Run the client program by executing the following command.

::: out nats-basic-pub.out :::

## Related links
- [`nats:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/clients/Client)
- [NATS publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#3-publishing)
