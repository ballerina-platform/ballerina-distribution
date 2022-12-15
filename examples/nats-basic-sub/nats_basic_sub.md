# NATS service - Consume message

NATS implements a publish-subscribe message distribution model. A publisher sends a message to a subject and any active subscriber listening to that subject can consume the message. In this example, the NATS service is used to consume messages from a subject.

::: code nats_basic_sub.bal :::

To run the sample, start an instance of the NATS server and execute the following command.

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats_basic_sub.out :::

>**Tip:** You can invoke the above service via the [NATS client](/learn/by-example/nats-basic-pub/).

## Related links
- [`nats` package - API documentation](https://lib.ballerina.io/ballerinax/nats/latest)
- [NATS subscribing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#4-subscribing)
