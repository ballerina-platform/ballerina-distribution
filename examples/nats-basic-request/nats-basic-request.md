# NATS client - Send request message

NATS supports the Request-Reply pattern using its core message distribution model, publish, and subscribe. A request is sent to a given subject and consumers listening to that subject can send responses to the reply subject of the message consumed. A `nats:Client` can be created with the default URL or with custom configurations. The `requestMessage` function can be used to send request messages to the NATS server by providing a target subject, an optional reply subject, the message content and an optional duration for timeout. The messages sent are received by any active subscriber listening on that subject. After the request is sent, the application waits on the response with the given timeout.

::: code nats-basic-request.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).
- Run the NATS service given in the [NATS service - Send reply to request message](/learn/by-example/nats-basic-reply/) example.

Run the client program by executing the following command.

::: out nats-basic-request.out :::

## Related links
- [`nats:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/clients/Client)
- [NATS publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#3-publishing)
