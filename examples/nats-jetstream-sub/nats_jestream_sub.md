# NATS service - Consume message

The `nats:JetStreamService` listens to the given subject for incoming messages. When a publisher sends a message to a subject, any active service listening to that subject receives the message. A `nats:JetStreamListener`  is created by passing an instance of NATS client. A `nats:StreamService` attached to the `nats:JetStreamListener` can be used to listen to a specific subject and consume incoming messages. The subject to listen to should be given as the service name or in the `subject` field of the `nats:StreamServiceConfig`. Use it to listen to messages sent to a particular subject.

::: code nats_jestream_sub.bal :::

## Prerequisites
- Start an instance of the [NATS server with JetStream enabled](https://docs.nats.io/running-a-nats-service/configuration/resource_management).

Run the service by executing the following command.

::: out nats_jestream_sub.out :::

>**Tip:** You can invoke the above service via the [NATS JetStream client](/learn/by-example/nats-jetstream-pub/).

## Related links
- [`nats` package - API documentation](https://lib.ballerina.io/ballerinax/nats/latest)
