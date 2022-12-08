# NATS client - Publish message

NATS implements a publish-subscribe message distribution model for one-to-many communication. A `nats:Client` can be created with the default URL or with custom configurations. The `publishMessage` function can be used to send messages to the NATS server by providing a target subject, an optional reply subject and the message content. The messages sent are received by any active subscriber listening on that subject.

::: code nats-basic-pub.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).
- Run the NATS service given in the [NATS service - Consume message](/learn/by-example/nats-basic-sub/) example.

Run the client program by executing the following command.

::: out nats-basic-pub.out :::

## Related links
- [`nats:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/clients/Client)
- [NATS publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#3-publishing)
