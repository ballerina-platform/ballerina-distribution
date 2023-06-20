# NATS JetStream client - Publish message

The `nats:JetStreamClient` allows you to publish messages to a specific subject. To create a `nats:JetStreamClient`, you need to provide a valid instance of the `nats:Client`. Before publishing messages, you should call the addStream function to configure the stream. This function requires a `nats:JetStreamConfiguration` object with the values `name`, `subjects`, and `storageType`. To publish messages, you can use the `publishMessage` method, which takes the message content and subject as arguments. This method allows you to send messages that can be received by one or more subscribers.

::: code nats_jetstream_pub.bal :::

## Prerequisites
- Start an instance of the [NATS JetStream erver](https://docs.nats.io/running-a-nats-service/configuration/resource_management).
- Run the NATS JetStream service given in the [NATS JetStream service - Consume message](/learn/by-example/nats-jetstream-sub/) example.

Run the client program by executing the following command.

::: out nats_jetstream_pub.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out nats_jetstream_pub.client.out :::

## Related links
- [`nats:JetStreamClient` client object - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/clients/JetStreamClient)
