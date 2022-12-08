# NATS service - Send reply to request message

NATS supports the Request-Reply pattern using its core message distribution model, publish, and subscribe. A request is sent to a given subject and consumers listening to that subject can send responses to the reply subject of the message consumed. A `nats:Listener` can be created with the default URL or with custom configurations. A `nats:Service` attached to the `nats:Listener` can be used to send replies to incoming request messages. The subject to listen to should be given as the service name or in the `subject` field of the `nats:ServiceConfig`.

::: code nats-basic-reply.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats-basic-reply.out :::

>**Tip:** You can invoke the above service via the [NATS client](/learn/by-example/nats-basic-request/).

## Related links
- [`nats` package - API documentation](https://lib.ballerina.io/ballerinax/nats/latest)
- [NATS subscribing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#4-subscribing)
