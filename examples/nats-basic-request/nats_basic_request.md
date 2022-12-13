# NATS client - Send request message

NATS supports the Request-Reply pattern using its core message distribution model, publish, and subscribe. A request is sent to a given subject and consumers listening to that subject can send responses to the reply subject. In this example, the NATS client is used to send a request to a subject.

::: code nats_basic_request.bal :::

## Prerequisites
- Start an instance of the [NATS server](https://docs.nats.io/nats-concepts/what-is-nats/walkthrough_setup).
- Run the NATS service given in the [NATS service - Send reply to request message](/learn/by-example/nats-basic-reply/) example.

Run the client program by executing the following command.

::: out nats_basic_request.server.out :::

Invoke the service by executing the following cURL command in a new terminal.

::: out nats_basic_request.client.out :::

## Related links
- [`nats:Client` client object - API documentation](https://lib.ballerina.io/ballerinax/nats/latest/clients/Client)
- [NATS publishing - Specification](https://github.com/ballerina-platform/module-ballerinax-nats/blob/master/docs/spec/spec.md#3-publishing)
