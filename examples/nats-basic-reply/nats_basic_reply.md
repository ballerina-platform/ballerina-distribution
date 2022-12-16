# NATS service - Send reply to request message

The NATS service allows listening to a given subject for incoming messages and sending responses. A NATS listener is created by passing the URL of the NATS broker. A `nats:Service` attached to the listener can be used to send replies to incoming request messages using the `onRequest` remote method. The subject to listen to should be given as the service name or in the `subject` field of the `nats:ServiceConfig`. Use it to send reply messages to the request messages consumed by the subscriber.

::: code nats_basic_reply.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).

Run the service by executing the following command.

::: out nats_basic_reply.out :::

>**Tip:** You can invoke the above service via the [NATS client](/learn/by-example/nats-basic-request/).

## Related links
- [`nats` package - API documentation](https://lib.ballerina.io/ballerinax/nats/latest)
- [NATS subscribing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#4-subscribing)
