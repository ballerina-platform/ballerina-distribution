# NATS JetStream service - Consume message

The `nats:JetStreamService` listens to a specified subject for incoming messages. Whenever a publisher sends a message to that subject, any active service listening to it will receive the message. To create a `nats:JetStreamListener`, you need to provide an instance of the `nats:Client`. Once you have a `nats:JetStreamListener`, you can attach a `nats:JetStreamService` to it in order to listen to a specific subject and consume incoming messages. The subject to listen to can be either specified as the service path or provided in the `subject` field of the `nats:StreamServiceConfig`. This setup allows you to effectively listen to messages sent to a particular subject.

::: code nats_jestream_sub.bal :::

## Prerequisites
- Start an instance of the [NATS JetStream server](https://docs.nats.io/running-a-nats-service/configuration/resource_management).

Run the service by executing the following command.

::: out nats_jestream_sub.out :::

>**Tip:** You can invoke the above service via the [NATS JetStream client](/learn/by-example/nats-jetstream-pub/).

## Related links
- [`nats` package - API documentation](https://lib.ballerina.io/ballerinax/nats/latest)
