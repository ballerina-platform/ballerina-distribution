# NATS client - Publish message

The NATS client allows publishing messages to a given subject. A NATS client is created by passing the URL of the NATS broker. To publish messages, the `publishMessage` method is used which requires the message and subject as arguments. Use it when you want to publish messages that can be received by one or more subscribers.

::: code nats_basic_pub.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).
- Run the NATS service given in the [NATS service - Consume message](/learn/by-example/nats-basic-sub/) example.

Run the client program by executing the following command.

::: out nats_basic_pub.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out nats_basic_pub.client.out :::

## Related links
- [`nats:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/clients/Client)
- [NATS publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#3-publishing)
