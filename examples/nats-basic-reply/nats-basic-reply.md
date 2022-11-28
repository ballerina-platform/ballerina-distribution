# NATS service - Send reply to request message

NATS supports the Request-Reply pattern using its core message distribution model, publish, and subscribe. A request is sent to a given subject and consumers listening to that subject can send responses to the reply subject. In this example, the NATS service is used to send replies to incoming request messages. 

::: code nats-basic-reply.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats-basic-reply.out :::

>**Tip:** You can invoke the above service via the [NATS client](/learn/by-example/nats-basic-request/).

## Related links
- [`nats` package - API documentation](https://lib.ballerina.io/ballerinax/nats/latest)
- [`nats` subscribing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#4-subscribing)
