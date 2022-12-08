# NATS service - Consume message

NATS implements a publish-subscribe message distribution model for one-to-many communication. A publisher sends a message on a subject and any active subscriber listening on that subject receives the message. Subscribers can also register interest in wildcard subjects. A `nats:Listener` can be created with the default URL or with custom configurations. A `nats:Service` attached to the `nats:Listener` can be used to listen to a specific subject and consume incoming messages. The subject to listen to should be given as the service name or in the `subject` field of the `nats:ServiceConfig`

::: code nats-basic-sub.bal :::

To run the sample, start an instance of the NATS server and execute the following command.

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats-basic-sub.out :::

>**Tip:** You can invoke the above service via the [NATS client](/learn/by-example/nats-basic-pub/).

## Related links
- [`nats` package - API documentation](https://lib.ballerina.io/ballerinax/nats/latest)
- [NATS subscribing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#4-subscribing)
