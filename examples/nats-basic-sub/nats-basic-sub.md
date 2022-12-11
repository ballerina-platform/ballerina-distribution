# NATS service - Consume message

The NATS service listens to the given subject for incoming messages. When a publisher sends a message on a subject, any active service listening on that subject receives the message. A NATS listener  is created by passing the URL of the NATS broker. A `nats:Service` attached to the `nats:Listener` can be used to listen to a specific subject and consume incoming messages. The subject to listen to should be given as the service name or in the `subject` field of the `nats:ServiceConfig`. Use it to listen to messages sent to a particular subject.

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
